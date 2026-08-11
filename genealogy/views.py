import json
from datetime import datetime
from django.shortcuts import render, get_object_or_404, redirect
from django.db import transaction
from django.db.models import Q
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth import login, logout
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.models import User
from django.utils import timezone
from django.http import HttpResponse, HttpResponseForbidden

from .models import (Person, Relationship, Marriage, Document, Event,
    UserProfile, AuditLog, PendingEdit)
from .forms import (RegisterForm, PersonForm, ProposePersonForm,
    RelationshipForm, MarriageForm, DocumentForm, EventForm,
    SearchForm, GedcomImportForm)
from .gedcom_dates import gedcom_to_display, calc_age, parse_gedcom_date


# ─── Helpers ─────────────────────────────────────────────────────────────────

def get_profile(user):
    if not user.is_authenticated:
        return None
    profile, _ = UserProfile.objects.get_or_create(user=user, defaults={'role': 'pending'})
    return profile


def record_audit(user, action, obj, changes=None, note=''):
    AuditLog.objects.create(
        user=user, action=action,
        model_name=obj.__class__.__name__,
        object_id=obj.pk, object_repr=str(obj),
        changes=changes or {}, note=note,
    )

def model_to_dict_simple(instance):
    data = {}
    for field in instance._meta.fields:
        val = getattr(instance, field.name)
        if hasattr(val, 'pk'):
            val = str(val)
        data[field.name] = val if val is not None else ''
    return data

def diff_dicts(old, new):
    return {k: [old.get(k), new.get(k)] for k in new
            if k not in ('created_at','updated_at','id') and old.get(k) != new.get(k)}

# ─── Auth ─────────────────────────────────────────────────────────────────────

def login_view(request):
    if request.user.is_authenticated:
        return redirect('genealogy:dashboard')
    form = AuthenticationForm(request, data=request.POST or None)
    if request.method == 'POST' and form.is_valid():
        login(request, form.get_user())
        return redirect(request.GET.get('next', '/argief/'))
    return render(request, 'genealogy/login.html', {'form': form})

def logout_view(request):
    logout(request)
    return redirect('genealogy:person_list')

def register_view(request):
    if request.user.is_authenticated:
        return redirect('genealogy:dashboard')
    form = RegisterForm(request.POST or None)
    if request.method == 'POST' and form.is_valid():
        user = form.save()
        login(request, user)
        messages.success(request,
            'Welkom! U rekening wag op goedkeuring deur ʼn van Eeden-familiebeheerder. '
            'U kan intussen in die argief blaai.')
        return redirect('genealogy:person_list')
    return render(request, 'genealogy/register.html', {'form': form})

# ─── Dashboard ────────────────────────────────────────────────────────────────

def dashboard(request):
    profile = get_profile(request.user)
    pending_count, pending_members, pending_edits = 0, [], []
    if profile and profile.is_admin:
        pending_count   = PendingEdit.objects.filter(status='pending').count()
        pending_members = UserProfile.objects.filter(role='pending').select_related('user')
        pending_edits   = PendingEdit.objects.filter(status='pending').select_related('proposed_by')[:10]
    return render(request, 'genealogy/dashboard.html', {
        'total_people':    Person.objects.count(),
        'total_marriages': Marriage.objects.count(),
        'total_documents': Document.objects.count(),
        'recent_people':   Person.objects.order_by('-created_at')[:6],
        'recent_audit':    AuditLog.objects.select_related('user')[:8],
        'profile': profile, 'pending_count': pending_count,
        'pending_members': pending_members, 'pending_edits': pending_edits,
    })

# ─── People ───────────────────────────────────────────────────────────────────

def person_list(request):
    profile = get_profile(request.user)
    sort = request.GET.get('sort', 'name')
    # Match SearchForm field names exactly
    q          = request.GET.get('query', '')
    gender     = request.GET.get('gender', '')
    birth_from = request.GET.get('birth_year_from', '')
    birth_to   = request.GET.get('birth_year_to', '')

    people = Person.objects.all()

    if q:
        people = people.filter(
            Q(first_name__icontains=q)  |
            Q(middle_name__icontains=q) |
            Q(last_name__icontains=q)   |
            Q(maiden_name__icontains=q) |
            Q(birth_place__icontains=q)
        )
    if gender:
        people = people.filter(gender=gender)

    # Birth year filtering — done in Python since birth_date is a CharField
    if birth_from or birth_to:
        filtered = []
        try:
            from_year = int(birth_from) if birth_from else None
            to_year   = int(birth_to)   if birth_to   else None
        except ValueError:
            from_year = to_year = None
        for p in people:
            try:
                year = int(p.birth_year) if p.birth_year else None
            except (ValueError, TypeError):
                year = None
            if year is None:
                continue
            if from_year and year < from_year:
                continue
            if to_year and year > to_year:
                continue
            filtered.append(p)
        people = filtered

    # Convert queryset to list if needed before sorting
    if hasattr(people, 'order_by'):
        if sort not in ('birth', 'henry'):
            people = list(people.order_by('last_name', 'first_name'))
        else:
            people = list(people)

    if sort == 'birth':
        people = sorted(people, key=lambda p: int(p.birth_year) if p.birth_year else 9999)

    # Compute Henry numbers
    from .henry import compute_henry_for_tree
    import re as _re
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)

    # Filter to only people with Henry numbers if requested
    henry_only = request.GET.get('henry_only', '')
    if henry_only:
        people = [p for p in people if p.pk in henry_map]

    def henry_sort_key(henry_str):
        """Sort Henry numbers numerically: a1b2c11 > a1b2c2"""
        if not henry_str:
            return []
        # Split into (letters, number) pairs: a1b2c11 -> [('a',1),('b',2),('c',11)]
        parts = _re.findall(r'([a-z]+)(\d+)', henry_str)
        return [(letters, int(num)) for letters, num in parts]

    # Sort
    if sort == 'henry' and henry_map:
        people = sorted(people,
            key=lambda p: henry_sort_key(henry_map.get(p.pk, '')))
    elif sort == 'birth':
        people = sorted(people, key=lambda p: p.birth_year or 9999)
    else:
        people = list(people.order_by('first_name', 'last_name')) if hasattr(people, 'order_by') else sorted(people, key=lambda p: (p.first_name, p.last_name))

    # View mode: cards or table
    view_mode = request.GET.get('view', 'cards')

    form = SearchForm(request.GET or None)
    return render(request, 'genealogy/person_list.html', {
        'people': people, 'profile': profile, 'sort': sort,
        'form': form, 'henry_map': henry_map,
        'q': q, 'gender': gender, 'birth_from': birth_from, 'birth_to': birth_to,
        'henry_only': henry_only, 'view_mode': view_mode,
    })


def person_detail(request, pk):
    profile  = get_profile(request.user)
    person   = get_object_or_404(Person, pk=pk)
    parents  = person.get_parents()
    children = person.get_children()
    spouses  = person.get_spouses()

    # Timeline — sort by year extracted from GEDCOM string
    timeline = []
    def tl_year(gedcom_str):
        p = parse_gedcom_date(gedcom_str)
        return p.get('year', 0) if p else 0

    def tl_sort_key(gedcom_str):
        """Sort key using year, month, day for correct chronological order."""
        p = parse_gedcom_date(gedcom_str) if gedcom_str else None
        if not p:
            return (0, 0, 0)
        return (
            int(p.get('year',  0) or 0),
            int(p.get('month', 0) or 0),
            int(p.get('day',   0) or 0),
        )

    if person.birth_date:
        timeline.append({'date': person.birth_date_display,
            'year': tl_year(person.birth_date), 'raw_date': person.birth_date,
            'label': 'Gebore', 'place': person.birth_place, 'type': 'birth'})
    for sp in spouses:
        m = sp['marriage']
        if m.marriage_date:
            timeline.append({'date': m.marriage_date_display,
                'year': tl_year(m.marriage_date), 'raw_date': m.marriage_date,
                'label': f'Getroud met {sp["person"].full_name}',
                'place': m.marriage_place, 'type': 'marriage'})
        if m.end_date:
            timeline.append({'date': m.end_date_display,
                'year': tl_year(m.end_date), 'raw_date': m.end_date,
                'label': f'{m.get_status_display()} van {sp["person"].full_name}',
                'place': m.end_place, 'type': 'marriage_end'})
    for event in person.events.all():
        if event.date:
            timeline.append({'date': event.date_display,
                'year': tl_year(event.date), 'raw_date': event.date,
                'label': event.title, 'place': event.place, 'type': 'event'})
    if person.death_date:
        timeline.append({'date': person.death_date_display,
            'year': tl_year(person.death_date), 'raw_date': person.death_date,
            'label': 'Oorlede', 'place': person.death_place, 'type': 'death'})
    timeline.sort(key=lambda x: tl_sort_key(x.get('raw_date', '')))

    audit_log = AuditLog.objects.filter(model_name='Person', object_id=pk).select_related('user')

    # ── Sort key ────────────────────────────────────────────────────────────────
    def _birth_key(item):
        p = item['person'] if isinstance(item, dict) else item
        try:
            return int(p.birth_year) if p.birth_year else 9999
        except (ValueError, TypeError):
            return 9999

    # ── Henry helpers ────────────────────────────────────────────────────────────
    from .henry import get_henry_number, compute_henry_for_tree
    import re as _re
    root = Person.objects.filter(is_root=True).first()
    henry_map = compute_henry_for_tree(root) if root else {}

    def _henry(p):
        return henry_map.get(p.pk, '')

    def _short_henry(p, pairs=1):
        """Return last N letter-number pairs from Henry number.
        pairs=1 -> 'j2', pairs=2 -> 'i2j2'
        """
        hn = _henry(p)
        if not hn:
            return ''
        parts = _re.findall(r'[a-z]+\d+', hn)
        if not parts:
            return ''
        return ''.join(parts[-pairs:]) if len(parts) >= pairs else ''.join(parts)

    henry_number = henry_map.get(person.pk, '')

    # ── Blood parents and non-blood parents ─────────────────────────────────────
    NON_BLOOD = {'adoptive_parent': 'Aangeneem', 'step_parent': 'Stiefkind', 'guardian': 'Pleegkind'}
    blood_parents = []
    non_blood_parents = []
    seen_parent_pks = set()
    for rel in person.child_relationships.all():
        if rel.relationship_type == 'parent':
            if rel.person.pk not in seen_parent_pks:
                blood_parents.append({
                    'person': rel.person,
                    'short_henry': _short_henry(rel.person, 1)
                })
                seen_parent_pks.add(rel.person.pk)
        elif rel.relationship_type in NON_BLOOD:
            if rel.person.pk not in seen_parent_pks:
                non_blood_parents.append({
                    'person': rel.person,
                    'label': NON_BLOOD[rel.relationship_type],
                    'short_henry': _short_henry(rel.person, 1)
                })
                seen_parent_pks.add(rel.person.pk)

    # ── Children ─────────────────────────────────────────────────────────────────
    blood_children = []
    non_blood_children = []
    for rel in person.person_relationships.all():
        if rel.relationship_type == 'parent':
            blood_children.append({'person': rel.relative, 'label': None, 'short_henry': _short_henry(rel.relative, 2)})
        elif rel.relationship_type in NON_BLOOD:
            non_blood_children.append({'person': rel.relative, 'label': NON_BLOOD[rel.relationship_type], 'short_henry': _short_henry(rel.relative, 2)})

    blood_children     = sorted(blood_children,     key=_birth_key)
    non_blood_children = sorted(non_blood_children, key=_birth_key)

    # ── Sibling classification ───────────────────────────────────────────────────
    # Extract Person objects from blood_parents dicts for algorithm use
    blood_parent_persons = [entry['person'] for entry in blood_parents]

    # Blood parents PKs of current person
    my_blood_parent_pks = set(p.pk for p in blood_parent_persons)

    # Collect all potential siblings via blood parents and their spouses
    blood_sibs      = {}  # pk -> person  (share BOTH biological parents)
    half_sibs       = {}  # pk -> person  (share ONE biological parent)
    step_sibs       = {}  # pk -> person  (no shared biological parent, connected via marriage)

    # Step 1: children of my blood parents
    for parent in blood_parent_persons:
        for child in parent.get_children():
            if child.pk == person.pk:
                continue
            child_parent_pks = set(
                r.person.pk for r in child.child_relationships.filter(relationship_type='parent')
            )
            shared = my_blood_parent_pks & child_parent_pks
            if len(shared) == len(my_blood_parent_pks) and len(shared) == len(child_parent_pks):
                blood_sibs[child.pk] = child
            elif shared:
                half_sibs[child.pk] = child
            else:
                half_sibs[child.pk] = child  # connected through parent, at least one shared

    # Step 2: step-siblings via parents' spouses
    for parent in blood_parent_persons:
        for sp_info in parent.get_spouses():
            spouse = sp_info['person']
            for child in spouse.get_children():
                if child.pk == person.pk:
                    continue
                if child.pk in blood_sibs or child.pk in half_sibs:
                    continue
                child_parent_pks = set(
                    r.person.pk for r in child.child_relationships.filter(relationship_type='parent')
                )
                if my_blood_parent_pks & child_parent_pks:
                    half_sibs[child.pk] = child
                else:
                    step_sibs[child.pk] = child

    # Gender-aware labels
    def _sib_label(p, prefix):
        if p.gender == 'M':
            return f'{prefix}broer'
        elif p.gender == 'F':
            return f'{prefix}suster'
        return f'{prefix}sib'

    # Blood takes priority over half, half over step — deduplicate
    seen_sib_pks = set()
    classified_siblings = []

    for p in blood_sibs.values():
        if p.pk not in seen_sib_pks:
            classified_siblings.append({
                'person': p, 'short_henry': _short_henry(p, 2),
                'label': _sib_label(p, ''),
                'type': 'blood'
            })
            seen_sib_pks.add(p.pk)

    for p in half_sibs.values():
        if p.pk not in seen_sib_pks:
            classified_siblings.append({
                'person': p, 'short_henry': _short_henry(p, 2),
                'label': _sib_label(p, 'Half'),
                'type': 'half'
            })
            seen_sib_pks.add(p.pk)

    for p in step_sibs.values():
        if p.pk not in seen_sib_pks:
            classified_siblings.append({
                'person': p, 'short_henry': _short_henry(p),
                'label': _sib_label(p, 'Stief'),
                'type': 'step'
            })
            seen_sib_pks.add(p.pk)

    classified_siblings = sorted(classified_siblings, key=_birth_key)

    return render(request, 'genealogy/person_detail.html', {
        'person': person, 'parents': blood_parents, 'children': blood_children,
        'non_blood_parents': non_blood_parents, 'non_blood_children': non_blood_children,
        'siblings': classified_siblings, 'spouses': spouses,
        'timeline': timeline, 'audit_log': audit_log, 'profile': profile,
        'henry_number': henry_number,
    })


@login_required
def person_create(request):
    profile = get_profile(request.user)
    if not profile.is_approved:
        messages.error(request, 'U rekening wag op goedkeuring.')
        return redirect('genealogy:person_list')
    if profile.can_edit:
        root_exists = Person.objects.filter(is_root=True).exists()
        show_root_checkbox = not root_exists
        if request.method == 'POST':
            form = PersonForm(request.POST, request.FILES)
            if form.is_valid():
                person = form.save(commit=False)
                person.created_by = request.user
                person.save()
                if profile.is_admin and show_root_checkbox and 'is_root' in request.POST:
                    person.is_root = True
                    person.save(update_fields=['is_root'])
                _create_person_document(request, person, 'birth')
                _create_person_document(request, person, 'death')
                record_audit(request.user, 'create', person, note=request.POST.get('note',''))
                messages.success(request, f'{person.full_name} is by die argief gevoeg.')
                return redirect('genealogy:person_detail', pk=person.pk)
        else:
            form = PersonForm()
        return render(request, 'genealogy/person_form.html',
            {'form': form, 'title': 'Voeg persoon by', 'live': True, 'profile': profile,
            'show_root_checkbox': show_root_checkbox})
    else:
        if request.method == 'POST':
            form = ProposePersonForm(request.POST)
            if form.is_valid():
                data = {k: str(v) if v else '' for k, v in form.cleaned_data.items() if k != 'note'}
                PendingEdit.objects.create(
                    proposed_by=request.user, action='create', model_name='Person',
                    object_repr=f"{form.cleaned_data['first_name']} {form.cleaned_data['last_name']}",
                    proposed_data=data, note=form.cleaned_data.get('note',''),
                )
                messages.success(request, 'U voorstel is ingedien en wag op hersiening. Dankie!')
                return redirect('genealogy:person_list')
        else:
            form = ProposePersonForm()
        return render(request, 'genealogy/person_form.html',
            {'form': form, 'title': 'Stel persoon voor', 'live': False, 'profile': profile})


@login_required
def person_edit(request, pk):
    profile = get_profile(request.user)
    person  = get_object_or_404(Person, pk=pk)
    if not profile.is_approved:
        messages.error(request, 'U rekening wag op goedkeuring.')
        return redirect('genealogy:person_detail', pk=pk)
    if profile.can_edit:
        old_data = model_to_dict_simple(person)
        other_root_exists = Person.objects.filter(is_root=True).exclude(pk=person.pk).exists()
        show_root_checkbox = not other_root_exists
        if request.method == 'POST':
            form = PersonForm(request.POST, request.FILES, instance=person)
            if form.is_valid():
                updated = form.save()
                if profile.is_admin and show_root_checkbox:
                    new_is_root = 'is_root' in request.POST
                    if updated.is_root != new_is_root:
                        if new_is_root:
                            Person.objects.filter(is_root=True).exclude(pk=updated.pk).update(is_root=False)
                        updated.is_root = new_is_root
                        updated.save(update_fields=['is_root'])
                _create_person_document(request, updated, 'birth')
                _create_person_document(request, updated, 'death')
                record_audit(request.user, 'update', updated,
                    diff_dicts(old_data, model_to_dict_simple(updated)),
                    note=request.POST.get('note',''))
                messages.success(request, f'{person.full_name} is opgedateer.')
                return redirect('genealogy:person_detail', pk=pk)
        else:
            form = PersonForm(instance=person)
        return render(request, 'genealogy/person_form.html',
            {'form': form, 'title': 'Wysig persoon', 'person': person,
            'live': True, 'profile': profile, 'show_root_checkbox': show_root_checkbox})
    else:
        old_data = model_to_dict_simple(person)
        if request.method == 'POST':
            form = ProposePersonForm(request.POST)
            if form.is_valid():
                new_data = {k: str(v) if v else '' for k, v in form.cleaned_data.items() if k != 'note'}
                PendingEdit.objects.create(
                    proposed_by=request.user, action='update', model_name='Person',
                    object_id=person.pk, object_repr=str(person),
                    proposed_data=new_data, field_changes=diff_dicts(old_data, new_data),
                    note=form.cleaned_data.get('note',''),
                )
                messages.success(request, 'U voorgestelde wysiging is ingedien vir hersiening.')
                return redirect('genealogy:person_detail', pk=pk)
        else:
            form = ProposePersonForm(instance=person)
        return render(request, 'genealogy/person_form.html',
            {'form': form, 'title': 'Stel wysiging voor', 'person': person,
            'live': False, 'profile': profile})


@login_required
def person_delete(request, pk):
    profile = get_profile(request.user)
    if not profile.can_delete:
        return HttpResponseForbidden('Slegs beheerders kan rekords verwyder.')
    person = get_object_or_404(Person, pk=pk)
    if request.method == 'POST':
        name = person.full_name
        record_audit(request.user, 'delete', person)
        person.delete()
        messages.success(request, f'{name} is uit die argief verwyder.')
        return redirect('genealogy:person_list')
    return render(request, 'genealogy/person_confirm_delete.html', {'person': person})


@login_required
def person_add_child(request, pk):
    """Koppel 'n kind aan 'n ouer — as 'n splinternuwe persoon, of as 'n bestaande persoon."""
    profile = get_profile(request.user)
    parent  = get_object_or_404(Person, pk=pk)

    if not profile.is_approved:
        messages.error(request, 'U rekening wag op goedkeuring.')
        return redirect('genealogy:person_detail', pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan kinders koppel.')
        return redirect('genealogy:person_detail', pk=pk)

    mode = 'new'
    person_form       = PersonForm()
    relationship_form = RelationshipForm()

    if request.method == 'POST':
        mode = request.POST.get('mode', 'new')

        if mode == 'new':
            person_form = PersonForm(request.POST, request.FILES)
            if person_form.is_valid():
                child = person_form.save(commit=False)
                child.created_by = request.user
                child.save()
                _create_person_document(request, child, 'birth')
                _create_person_document(request, child, 'death')
                record_audit(request.user, 'create', child, note=request.POST.get('note', ''))

                rel = Relationship.objects.create(
                    person=parent, relative=child, relationship_type='parent',
                )
                record_audit(request.user, 'create', rel)

                messages.success(request, f'{child.full_name} is as kind van {parent.full_name} bygevoeg.')
                return redirect('genealogy:person_detail', pk=parent.pk)

        elif mode == 'existing':
            relationship_form = RelationshipForm(request.POST, request.FILES)
            if relationship_form.is_valid():
                rel = relationship_form.save(commit=False)
                rel.person = parent
                rel.save()
                _create_relationship_document(request, rel)
                record_audit(request.user, 'create', rel, note=request.POST.get('note', ''))

                messages.success(request, f'{rel.relative.full_name} is as kind van {parent.full_name} gekoppel.')
                return redirect('genealogy:person_detail', pk=parent.pk)

    # Data for the "Bestaande Inskrywing" (existing person) picker
    connected_child_pks = Relationship.objects.values_list('relative__pk', flat=True)
    unconnected_people = Person.objects.exclude(pk__in=connected_child_pks).exclude(pk=parent.pk) \
        .order_by('first_name', 'last_name')
    all_people = Person.objects.exclude(pk=parent.pk).order_by('first_name', 'last_name')

    from .henry import compute_henry_for_tree
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)

    return render(request, 'genealogy/person_add_child.html', {
        'parent': parent,
        'person_form': person_form,
        'relationship_form': relationship_form,
        'profile': profile,
        'mode': mode,
        'unconnected_people': unconnected_people,
        'all_people': all_people,
        'henry_map': henry_map,
    })


@login_required
def person_add_spouse(request, pk):
    """Voeg 'n gade by 'n persoon — as 'n splinternuwe persoon, of as 'n bestaande persoon."""
    profile = get_profile(request.user)
    person1 = get_object_or_404(Person, pk=pk)

    if not profile.is_approved:
        messages.error(request, 'U rekening wag op goedkeuring.')
        return redirect('genealogy:person_detail', pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan gades koppel.')
        return redirect('genealogy:person_detail', pk=pk)

    mode = 'new'
    person_form         = PersonForm()
    marriage_form_new      = MarriageForm(auto_id='mnew_%s')
    marriage_form_existing = MarriageForm(auto_id='mexist_%s')

    if request.method == 'POST':
        mode = request.POST.get('mode', 'new')

        if mode == 'new':
            person_form = PersonForm(request.POST, request.FILES)
            if person_form.is_valid():
                with transaction.atomic():
                    sid = transaction.savepoint()
                    spouse = person_form.save(commit=False)
                    spouse.created_by = request.user
                    spouse.save()

                    m_data = request.POST.copy()
                    m_data['person1'] = str(person1.pk)
                    m_data['person2'] = str(spouse.pk)
                    m_data['notes']   = request.POST.get('marriage_notes', '')
                    marriage_form_new = MarriageForm(m_data, auto_id='mnew_%s')

                    if marriage_form_new.is_valid():
                        marriage = marriage_form_new.save()
                        _create_person_document(request, spouse, 'birth')
                        _create_person_document(request, spouse, 'death')
                        _create_marriage_document(request, marriage)
                        record_audit(request.user, 'create', spouse, note=request.POST.get('note', ''))
                        record_audit(request.user, 'create', marriage)
                        transaction.savepoint_commit(sid)
                        messages.success(request, f'{spouse.full_name} is as gade van {person1.full_name} bygevoeg.')
                        return redirect('genealogy:person_detail', pk=person1.pk)
                    else:
                        transaction.savepoint_rollback(sid)
                        # Re-bind an unsaved copy so the person fields redisplay with entered data
                        person_form = PersonForm(request.POST, request.FILES)
                        person_form.is_valid()

        elif mode == 'existing':
            m_data = request.POST.copy()
            m_data['person1'] = str(person1.pk)
            marriage_form_existing = MarriageForm(m_data, auto_id='mexist_%s')
            if marriage_form_existing.is_valid():
                marriage = marriage_form_existing.save()
                _create_marriage_document(request, marriage)
                record_audit(request.user, 'create', marriage, note=request.POST.get('note', ''))
                messages.success(request, f'{marriage.person2.full_name} is as gade van {person1.full_name} gekoppel.')
                return redirect('genealogy:person_detail', pk=person1.pk)

    from .henry import compute_henry_for_tree
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    all_people = list(Person.objects.exclude(pk=person1.pk).order_by('first_name', 'last_name'))
    no_henry_people = [p for p in all_people if p.pk not in henry_map]

    return render(request, 'genealogy/person_add_spouse.html', {
        'person1': person1,
        'person_form': person_form,
        'marriage_form_new': marriage_form_new,
        'marriage_form_existing': marriage_form_existing,
        'profile': profile,
        'mode': mode,
        'all_people': all_people,
        'no_henry_people': no_henry_people,
        'henry_map': henry_map,
    })


# ─── Admin: members ───────────────────────────────────────────────────────────

@login_required
def approve_member(request, user_id):
    profile = get_profile(request.user)
    if not profile.is_admin:
        return HttpResponseForbidden()
    tp = get_object_or_404(UserProfile, user_id=user_id)
    if request.method == 'POST':
        action = request.POST.get('action')
        if action == 'approve':
            tp.role = 'viewer'; tp.approved_by = request.user; tp.approved_at = timezone.now(); tp.save()
            messages.success(request, f'{tp.user.username} is as kyker goedgekeur.')
        elif action == 'trust':
            tp.role = 'trusted'; tp.approved_by = request.user; tp.approved_at = timezone.now(); tp.save()
            messages.success(request, f'{tp.user.username} is as vertroude lid aangewys.')
        elif action == 'reject':
            tp.role = 'pending'; tp.save()
            messages.warning(request, f'{tp.user.username} bly hangend.')
    return redirect('genealogy:dashboard')

@login_required
def member_edit(request, user_id):
    if not request.user.is_superuser:
        return HttpResponseForbidden()
    profile = get_profile(request.user)
    tp = get_object_or_404(UserProfile, user_id=user_id)
    if request.method == 'POST':
        # User fields
        tp.user.first_name = request.POST.get('first_name', '').strip()
        tp.user.last_name  = request.POST.get('last_name', '').strip()
        tp.user.email      = request.POST.get('email', '').strip()
        tp.user.save()
        # Profile fields
        tp.role = request.POST.get('role', tp.role)
        tp.bio  = request.POST.get('bio', '').strip()
        if tp.role != 'pending' and not tp.approved_at:
            tp.approved_by = request.user
            tp.approved_at = timezone.now()
        tp.save()
        messages.success(request, f'{tp.user.username} se profiel is opgedateer.')
        return redirect('genealogy:members_list')
    return render(request, 'genealogy/member_edit.html', {'tp': tp, 'profile': profile,
        'role_choices': UserProfile.ROLE_CHOICES})


@login_required
def member_delete(request, user_id):
    if not request.user.is_superuser:
        return HttpResponseForbidden()
    profile = get_profile(request.user)
    tp = get_object_or_404(UserProfile, user_id=user_id)
    if tp.user == request.user:
        messages.error(request, 'Jy kan nie jou eie rekening verwyder nie.')
        return redirect('genealogy:members_list')
    if request.method == 'POST':
        username = tp.user.username
        tp.user.delete()  # cascades to UserProfile
        messages.success(request, f'{username} is verwyder.')
        return redirect('genealogy:members_list')
    return render(request, 'genealogy/member_confirm_delete.html',
        {'tp': tp, 'profile': profile})


@login_required
def members_list(request):
    if not request.user.is_superuser:
        return HttpResponseForbidden()
    profile = get_profile(request.user)
    members = UserProfile.objects.select_related('user','approved_by').order_by('role','joined')
    return render(request, 'genealogy/members_list.html', {'members': members, 'profile': profile})


# ─── Admin: pending edits ─────────────────────────────────────────────────────

@login_required
def pending_edits(request):
    profile = get_profile(request.user)
    if not profile.is_admin:
        return HttpResponseForbidden()
    edits = PendingEdit.objects.filter(status='pending').select_related('proposed_by')
    return render(request, 'genealogy/pending_edits.html', {'edits': edits, 'profile': profile})


@login_required
def review_edit(request, edit_id):
    profile = get_profile(request.user)
    if not profile.is_admin:
        return HttpResponseForbidden()
    edit = get_object_or_404(PendingEdit, pk=edit_id)
    if request.method == 'POST':
        action      = request.POST.get('action')
        review_note = request.POST.get('review_note','')
        edit.reviewed_by = request.user
        edit.reviewed_at = timezone.now()
        edit.review_note = review_note
        if action == 'approve':
            edit.status = 'approved'; edit.save()
            if edit.model_name == 'Person':
                if edit.action == 'create':    _apply_person_create(edit, request.user)
                elif edit.action == 'update':  _apply_person_update(edit, request.user)
            messages.success(request, f'Wysiging goedgekeur en toegepas: {edit.object_repr}')
        elif action == 'reject':
            edit.status = 'rejected'; edit.save()
            messages.warning(request, f'Wysiging verwerp: {edit.object_repr}')
        return redirect('genealogy:pending_edits')
    existing = None
    if edit.object_id and edit.model_name == 'Person':
        try: existing = Person.objects.get(pk=edit.object_id)
        except Person.DoesNotExist: pass
    return render(request, 'genealogy/review_edit.html', {
        'edit': edit, 'existing': existing, 'profile': profile
    })


def _apply_person_create(edit, admin_user):
    d = edit.proposed_data
    p = Person.objects.create(
        first_name=d.get('first_name',''), middle_name=d.get('middle_name',''),
        last_name=d.get('last_name',''), maiden_name=d.get('maiden_name',''),
        gender=d.get('gender','U'),
        birth_date=d.get('birth_date',''), birth_place=d.get('birth_place',''),
        death_date=d.get('death_date',''), death_place=d.get('death_place',''),
        biography=d.get('biography',''), notes=d.get('notes',''),
        is_deceased=d.get('is_deceased','') in ('True','true',True),
        created_by=edit.proposed_by,
    )
    AuditLog.objects.create(user=admin_user, action='create', model_name='Person',
        object_id=p.pk, object_repr=str(p),
        note=f'Goedgekeur van voorstel deur {edit.proposed_by.username}')


def _apply_person_update(edit, admin_user):
    try: person = Person.objects.get(pk=edit.object_id)
    except Person.DoesNotExist: return
    old = model_to_dict_simple(person)
    d = edit.proposed_data
    for f in ['first_name','middle_name','last_name','maiden_name','gender',
        'birth_place','death_place','biography','notes','birth_date','death_date']:
        if f in d: setattr(person, f, d[f])
    if 'is_deceased' in d:
        person.is_deceased = d['is_deceased'] in ('True','true',True)
    person.save()
    AuditLog.objects.create(user=admin_user, action='update', model_name='Person',
        object_id=person.pk, object_repr=str(person),
        changes=diff_dicts(old, model_to_dict_simple(person)),
        note=f'Goedgekeur van voorstel deur {edit.proposed_by.username}')


# ─── Audit ────────────────────────────────────────────────────────────────────

def audit_log(request):
    profile = get_profile(request.user)
    logs = AuditLog.objects.select_related('user').all()
    return render(request, 'genealogy/audit_log.html', {'logs': logs, 'profile': profile})


# ─── Marriages ────────────────────────────────────────────────────────────────

def marriage_list(request):
    profile   = get_profile(request.user)
    marriages = list(Marriage.objects.select_related('person1','person2').all())
    from .henry import compute_henry_for_tree
    import re as _re
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    def h_key(m):
        hn = henry_map.get(m.person1.pk, '')
        parts = _re.findall(r'([a-z]+)(\d+)', hn)
        return [(l, int(n)) for l, n in parts] if parts else [('zzz', 9999)]
    marriages = sorted(marriages, key=h_key)
    return render(request, 'genealogy/marriage_list.html',
        {'marriages': marriages, 'profile': profile, 'henry_map': henry_map})


@login_required
def marriage_create(request):
    profile = get_profile(request.user)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan huwelike direk byvoeg.')
        return redirect('genealogy:marriage_list')
    if request.method == 'POST':
        form = MarriageForm(request.POST, request.FILES)
        if form.is_valid():
            m = form.save()
            _create_marriage_document(request, m)
            record_audit(request.user, 'create', m, note=request.POST.get('note',''))
            messages.success(request, 'Huwelik aangeteken.')
            return redirect('genealogy:marriage_detail', pk=m.pk)
    else:
        form = MarriageForm()
    # Pre-populate person1 if navigated from person_detail
    preselect_person1 = None
    person1_pk = request.GET.get('person1')
    if person1_pk:
        try:
            preselect_person1 = Person.objects.get(pk=person1_pk)
        except Person.DoesNotExist:
            pass
    from .henry import compute_henry_for_tree
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    all_people = list(Person.objects.all().order_by('first_name', 'last_name'))
    no_henry_people = [p for p in all_people if p.pk not in henry_map]
    return render(request, 'genealogy/marriage_form.html',
        {'form': form, 'title': 'Teken huwelik aan', 'profile': profile,
        'all_people': all_people,
        'no_henry_people': no_henry_people,
        'henry_map': henry_map,
        'marriage': type('obj', (object,), {'person1': preselect_person1, 'person2': None})()})


@login_required
def marriage_edit(request, pk):
    profile  = get_profile(request.user)
    marriage = get_object_or_404(Marriage, pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan huwelike wysig.')
        return redirect('genealogy:marriage_detail', pk=pk)
    old = model_to_dict_simple(marriage)
    if request.method == 'POST':
        form = MarriageForm(request.POST, request.FILES, instance=marriage)
        if form.is_valid():
            updated = form.save()
            _create_marriage_document(request, updated)
            record_audit(request.user, 'update', updated,
                diff_dicts(old, model_to_dict_simple(updated)),
                note=request.POST.get('note',''))
            messages.success(request, 'Huwelik opgedateer.')
            return redirect('genealogy:marriage_detail', pk=pk)
    else:
        form = MarriageForm(instance=marriage)
    # Fetch existing linked documents for display in the edit form
    existing_docs = Document.objects.filter(marriage=marriage)
    from .gedcom_dates import gedcom_to_display
    from .henry import compute_henry_for_tree
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    all_people = Person.objects.all().order_by('first_name', 'last_name')
    no_henry_people = [p for p in all_people if p.pk not in henry_map]
    return render(request, 'genealogy/marriage_form.html',
        {'form': form, 'title': 'Wysig huwelik', 'profile': profile,
        'marriage': marriage,
        'existing_docs': existing_docs,
        'marriage_date_display': gedcom_to_display(marriage.marriage_date),
        'end_date_display':      gedcom_to_display(marriage.end_date),
        'all_people': all_people,
        'no_henry_people': no_henry_people,
        'henry_map': henry_map})


def marriage_detail(request, pk):
    profile  = get_profile(request.user)
    marriage = get_object_or_404(Marriage, pk=pk)
    # Documents linked to either person in the marriage
    docs = Document.objects.filter(people__in=[marriage.person1, marriage.person2]).distinct()
    return render(request, 'genealogy/marriage_detail.html',
        {'marriage': marriage, 'documents': docs, 'profile': profile})


@login_required
def marriage_delete(request, pk):
    profile  = get_profile(request.user)
    marriage = get_object_or_404(Marriage, pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan huwelike verwyder.')
        return redirect('genealogy:marriage_detail', pk=pk)
    if request.method == 'POST':
        record_audit(request.user, 'delete', marriage)
        # Delete documents linked to both persons in this marriage
        Document.objects.filter(marriage=marriage).delete()
        marriage.delete()
        messages.success(request, 'Huwelik en verwante dokumente verwyder.')
        return redirect('genealogy:marriage_list')
    return render(request, 'genealogy/marriage_confirm_delete.html',
        {'marriage': marriage, 'profile': profile})


# ─── Relationships ────────────────────────────────────────────────────────────

def relationship_list(request):
    profile = get_profile(request.user)
    relationships = list(Relationship.objects.select_related('person','relative').all())
    from .henry import compute_henry_for_tree
    import re as _re
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    def h_key(r):
        hn = henry_map.get(r.person.pk, '')
        parts = _re.findall(r'([a-z]+)(\d+)', hn)
        return [(l, int(n)) for l, n in parts] if parts else [('zzz', 9999)]
    relationships = sorted(relationships, key=h_key)
    return render(request, 'genealogy/relationship_list.html',
        {'relationships': relationships, 'profile': profile, 'henry_map': henry_map})

def relationship_detail(request, pk):
    profile      = get_profile(request.user)
    relationship = get_object_or_404(Relationship, pk=pk)
    # Documents linked to the child (relative) for adoptions/guardianships
    docs = Document.objects.filter(people=relationship.relative).distinct()
    return render(request, 'genealogy/relationship_detail.html',
        {'relationship': relationship, 'documents': docs, 'profile': profile})


@login_required
def relationship_create(request):
    profile = get_profile(request.user)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan verhoudings byvoeg.')
        return redirect('genealogy:person_list')
    if request.method == 'POST':
        form = RelationshipForm(request.POST, request.FILES)
        if form.is_valid():
            rel = form.save()
            _create_relationship_document(request, rel)
            record_audit(request.user, 'create', rel)
            messages.success(request, 'Verhouding bygevoeg.')
            return redirect('genealogy:relationship_detail', pk=rel.pk)
    else:
        form = RelationshipForm()
    # Pre-populate person (parent) if navigated from person_detail
    preselect_person = None
    person_pk = request.GET.get('person')
    if person_pk:
        try:
            preselect_person = Person.objects.get(pk=person_pk)
        except Person.DoesNotExist:
            pass
    # People who are not yet linked as a child in any relationship
    connected_child_pks = Relationship.objects.values_list('relative__pk', flat=True)
    unconnected_people = Person.objects.exclude(pk__in=connected_child_pks).order_by('first_name', 'last_name')
    from .henry import compute_henry_for_tree
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    return render(request, 'genealogy/relationship_form.html', {'form': form, 'profile': profile,
        'all_people': Person.objects.all().order_by('first_name', 'last_name'),
        'unconnected_people': unconnected_people,
        'henry_map': henry_map,
        'relationship': type('obj', (object,), {'person': preselect_person, 'relative': None})()})

@login_required
def relationship_edit(request, pk):
    profile = get_profile(request.user)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan verhoudings wysig.')
        return redirect('genealogy:person_list')
    relationship = get_object_or_404(Relationship, pk=pk)
    if request.method == 'POST':
        form = RelationshipForm(request.POST, request.FILES, instance=relationship)
        if form.is_valid():
            updated = form.save()
            _create_relationship_document(request, updated)
            record_audit(request.user, 'update', updated,
                diff_dicts(model_to_dict_simple(relationship), model_to_dict_simple(updated)),
                note=request.POST.get('note',''))
            messages.success(request, 'Verhouding opgedateer.')
            return redirect('genealogy:relationship_detail', pk=pk)
    else:
        form = RelationshipForm(instance=relationship)
    existing_docs = Document.objects.filter(relationship=relationship)
    connected_child_pks = Relationship.objects.exclude(pk=pk).values_list('relative__pk', flat=True)
    unconnected_people = Person.objects.exclude(pk__in=connected_child_pks).order_by('first_name', 'last_name')
    from .henry import compute_henry_for_tree
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    return render(request, 'genealogy/relationship_form.html', {'form': form, 'profile': profile,
        'relationship': relationship,
        'existing_docs': existing_docs,
        'unconnected_people': unconnected_people,
        'all_people': Person.objects.all().order_by('first_name', 'last_name'),
        'henry_map': henry_map})

def relationship_delete(request, pk):
    profile = get_profile(request.user)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan verhoudings verwyder.')
        return redirect('genealogy:person_list')
    relationship = get_object_or_404(Relationship, pk=pk)
    if request.method == 'POST':
        # Delete linked adoption/guardianship documents first
        Document.objects.filter(relationship=relationship).delete()
        record_audit(request.user, 'delete', relationship)
        relationship.delete()
        messages.success(request, 'Verhouding en verwante dokumente verwyder.')
        return redirect('genealogy:relationship_list')
    return render(request, 'genealogy/relationship_confirm_delete.html', {'relationship': relationship, 'profile': profile})



# ─── Documents ────────────────────────────────────────────────────────────────

def document_list(request):
    profile   = get_profile(request.user)
    documents = Document.objects.all()
    return render(request, 'genealogy/document_list.html', {'documents': documents, 'profile': profile})


def document_detail(request, pk):
    profile  = get_profile(request.user)
    document = get_object_or_404(Document, pk=pk)
    return render(request, 'genealogy/document_detail.html', {'document': document, 'profile': profile})


@login_required
def document_create(request):
    profile = get_profile(request.user)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan dokumente oplaai.')
        return redirect('genealogy:document_list')
    if request.method == 'POST':
        form = DocumentForm(request.POST, request.FILES)
        if form.is_valid():
            doc = form.save(commit=False)
            doc.uploaded_by = request.user
            doc.save(); form.save_m2m()
            record_audit(request.user, 'create', doc)
            messages.success(request, 'Dokument gevoeg.')
            return redirect('genealogy:document_list')
    else:
        form = DocumentForm()
        from .henry import compute_henry_for_tree
        henry_map = {}
        root = Person.objects.filter(is_root=True).first()
        if root:
            henry_map = compute_henry_for_tree(root)
    return render(request, 'genealogy/document_form.html',
        {'form': form, 'title': 'Voeg dokument by', 'profile': profile, 'all_people': Person.objects.all().order_by('first_name', 'last_name'), 'henry_map': henry_map})

@login_required
def document_edit(request, pk):
    profile  = get_profile(request.user)
    document = get_object_or_404(Document, pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan dokumente wysig.')
        return redirect('genealogy:document_detail', pk=pk)
    if request.method == 'POST':
        form = DocumentForm(request.POST, request.FILES, instance=document)
        if form.is_valid():
            doc = form.save(commit=False)
            doc.save(); form.save_m2m()
            record_audit(request.user, 'update', doc)
            messages.success(request, 'Dokument gewysig.')
            return redirect('genealogy:document_detail', pk=pk)
    else:
        form = DocumentForm(instance=document)
        from .henry import compute_henry_for_tree
        henry_map = {}
        root = Person.objects.filter(is_root=True).first()
        if root:
            henry_map = compute_henry_for_tree(root)
    return render(request, 'genealogy/document_form.html',
        {'form': form, 'title': 'Wysig dokument', 'profile': profile,
        'all_people': Person.objects.all().order_by('first_name', 'last_name'),
        'document': document, 'henry_map': henry_map})

@login_required
def document_delete(request, pk):
    profile  = get_profile(request.user)
    document = get_object_or_404(Document, pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan dokumente verwyder.')
        return redirect('genealogy:document_detail', pk=pk)
    if request.method == 'POST':
        record_audit(request.user, 'delete', document)
        document.delete()
        messages.success(request, 'Dokument verwyder.')
        return redirect('genealogy:document_list')
    return render(request, 'genealogy/document_confirm_delete.html',
        {'document': document, 'profile': profile})


# ─── Events ───────────────────────────────────────────────────────────────────

def event_list(request):
    profile = get_profile(request.user)
    events  = Event.objects.all()
    return render(request, 'genealogy/event_list.html', {'events': events, 'profile': profile})


@login_required
def event_create(request):
    profile = get_profile(request.user)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan gebeure byvoeg.')
        return redirect('genealogy:event_list')
    if request.method == 'POST':
        form = EventForm(request.POST, request.FILES)
        if form.is_valid():
            event = form.save()
            # Save main_person to FK and add to people
            main_pk = request.POST.get('main_person')
            if main_pk:
                try:
                    main_p = Person.objects.get(pk=main_pk)
                    event.main_person = main_p
                    event.save()
                    event.people.add(main_p)
                except Person.DoesNotExist:
                    pass
            _create_event_document(request, event)
            record_audit(request.user, 'create', event)
            messages.success(request, 'Gebeurtenis gevoeg.')
            return redirect('genealogy:event_detail', pk=event.pk)
    else:
        form = EventForm()
    from .henry import compute_henry_for_tree
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)
    return render(request, 'genealogy/event_form.html',
        {'form': form, 'title': 'Voeg gebeurtenis by', 'profile': profile,
        'all_people': Person.objects.all().order_by('last_name', 'first_name'),
        'henry_map': henry_map})

def event_detail(request, pk):
    profile = get_profile(request.user)
    event   = get_object_or_404(Event, pk=pk)
    from .gedcom_dates import parse_gedcom_date
    from .gedcom_dates import parse_gedcom_date
    docs = list(Document.objects.filter(event=event))
    main_person = event.main_person
    def doc_year(doc):
        p = parse_gedcom_date(doc.date)
        return int(p.get('year', 9999)) if p else 9999
    docs = sorted(docs, key=doc_year)
    return render(request, 'genealogy/event_detail.html',
        {'event': event, 'documents': docs, 'profile': profile,
        'main_person': main_person})

@login_required
def event_edit(request, pk):
    profile = get_profile(request.user)
    event   = get_object_or_404(Event, pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan gebeure wysig.')
        return redirect('genealogy:event_detail', pk=pk)
    if request.method == 'POST':
        form = EventForm(request.POST, request.FILES, instance=event)
        if form.is_valid():
            event = form.save()
            main_pk = request.POST.get('main_person')
            if main_pk:
                try:
                    main_p = Person.objects.get(pk=main_pk)
                    event.main_person = main_p
                    event.save()
                    event.people.add(main_p)
                except Person.DoesNotExist:
                    pass
            _create_event_document(request, event)
            record_audit(request.user, 'update', event)
            messages.success(request, 'Gebeurtenis gewysig.')
            return redirect('genealogy:event_detail', pk=pk)
    else:
        form = EventForm(instance=event)
        main_person = event.main_person
        existing_docs = Document.objects.filter(event=event)
        from .gedcom_dates import gedcom_to_display
        from .henry import compute_henry_for_tree
        henry_map = {}
        root = Person.objects.filter(is_root=True).first()
        if root:
            henry_map = compute_henry_for_tree(root)
    return render(request, 'genealogy/event_form.html',
        {'form': form, 'title': 'Wysig gebeurtenis', 'profile': profile,
        'all_people': Person.objects.all().order_by('first_name', 'last_name'),
        'event': event, 'main_person': main_person, 'existing_docs': existing_docs,
        'event_date_display': gedcom_to_display(event.date), 'henry_map': henry_map})

@login_required
def event_delete(request, pk):
    profile = get_profile(request.user)
    event   = get_object_or_404(Event, pk=pk)
    if not profile.can_edit:
        messages.error(request, 'Slegs vertroude lede kan gebeure verwyder.')
        return redirect('genealogy:event_detail', pk=pk)
    if request.method == 'POST':
        # Delete documents linked to the first person on this event
        Document.objects.filter(event=event).delete()
        record_audit(request.user, 'delete', event)
        event.delete()
        messages.success(request, 'Gebeurtenis en verwante dokumente verwyder.')
        return redirect('genealogy:event_list')
    return render(request, 'genealogy/event_confirm_delete.html',
        {'event': event, 'profile': profile})

# ─── Family tree ──────────────────────────────────────────────────────────────

def family_tree_data(request, pk):
    profile = get_profile(request.user)
    person  = get_object_or_404(Person, pk=pk)

    from .henry import compute_henry_for_tree
    import re as _re
    root = Person.objects.filter(is_root=True).first()
    henry_map = compute_henry_for_tree(root) if root else {}

    def _short_henry(p, pairs=1):
        hn = henry_map.get(p.pk, '')
        if not hn:
            return ''
        parts = _re.findall(r'[a-z]+\d+', hn)
        if not parts:
            return ''
        return ''.join(parts[-pairs:]) if len(parts) >= pairs else ''.join(parts)

    def build_node(p, depth=0, max_depth=4, visited=None):
        if visited is None: visited = set()
        if p.pk in visited or depth > max_depth: return None
        visited.add(p.pk)
        node = {
            'id': p.pk, 'name': p.full_name, 'gender': p.gender,
            'first_name': p.first_name,
            'middle_name': p.middle_name,
            'last_name': p.last_name,
            'birth_year': p.birth_year, 'death_year': p.death_year,
            'short_henry': _short_henry(p, 1),
            'url': p.get_absolute_url(), 'children': [],
        }
        for child in p.get_children():
            cn = build_node(child, depth+1, max_depth, visited)
            if cn: node['children'].append(cn)
        return node

    return render(request, 'genealogy/family_tree.html', {
        'person': person,
        'tree_json': json.dumps(build_node(person)),
        'profile': profile,
    })


# ─── Map ──────────────────────────────────────────────────────────────────────

def map_view(request):
    profile = get_profile(request.user)
    people  = Person.objects.exclude(Q(birth_place='') & Q(death_place=''))
    people_data = [{
        'id': p.pk, 'name': p.full_name, 'url': p.get_absolute_url(),
        'birth_place': p.birth_place, 'death_place': p.death_place,
        'birth_year': p.birth_year, 'death_year': p.death_year,
        'birth_lat': p.birth_lat, 'birth_lng': p.birth_lng,
        'death_lat': p.death_lat, 'death_lng': p.death_lng,
    } for p in people]
    return render(request, 'genealogy/map.html', {
        'people_json': json.dumps(people_data),
        'people_count': len(people_data), 'profile': profile,
    })


# ─── GEDCOM export ────────────────────────────────────────────────────────────

def export_gedcom(request):
    from .henry import compute_henry_for_tree
    # Build Henry map
    henry_map = {}
    root = Person.objects.filter(is_root=True).first()
    if root:
        henry_map = compute_henry_for_tree(root)

    lines = ['0 HEAD', '1 GEDC', '2 VERS 5.5.1', '1 CHAR UTF-8',
        '1 SOUR VanEedenArgief', '2 NAME Van Eeden Familieargief']
    for p in Person.objects.all():
        given = f'{p.first_name} {p.middle_name}'.strip() if p.middle_name else p.first_name
        lines += [f'0 @I{p.pk}@ INDI',
            f'1 NAME {given} /{p.last_name}/',
            f'2 GIVN {given}', f'2 SURN {p.last_name}']
        if p.gender in ('M','F'):
            lines.append(f'1 SEX {p.gender}')
        if p.birth_date or p.birth_place:
            lines.append('1 BIRT')
            if p.birth_date:  lines.append(f'2 DATE {p.birth_date}')
            if p.birth_place: lines.append(f'2 PLAC {p.birth_place}')
        if p.is_deceased or p.death_date:
            lines.append('1 DEAT Y')
            if p.death_date:  lines.append(f'2 DATE {p.death_date}')
            if p.death_place: lines.append(f'2 PLAC {p.death_place}')
        if p.biography:
            lines.append(f'1 NOTE {p.biography[:248]}')
        # Add Henry number as custom tag
        henry = henry_map.get(p.pk)
        if henry:
            lines.append(f'1 _HENRY {henry}')
        # Mark root person
        if p.is_root:
            lines.append('1 _ROOT Y')
    # Track which children have been assigned to a FAM record
    children_in_fam = set()
    fam_counter = 0

    for m in Marriage.objects.all():
        fam_counter += 1
        lines += [f'0 @F{fam_counter}@ FAM',
            f'1 HUSB @I{m.person1.pk}@',
            f'1 WIFE @I{m.person2.pk}@']
        if m.marriage_date:
            lines += ['1 MARR', f'2 DATE {m.marriage_date}']
        if m.marriage_place:
            lines.append(f'2 PLAC {m.marriage_place}')
        if m.status and m.status != 'married':
            lines.append(f'1 _STATUS {m.status}')
        # Export all children of either parent (deduped)
        all_children = {c.pk: c for c in m.person1.get_children()}
        all_children.update({c.pk: c for c in m.person2.get_children()})
        for child in all_children.values():
            lines.append(f'1 CHIL @I{child.pk}@')
            children_in_fam.add(child.pk)

    # Export parent-child relationships that have no marriage record
    # Group children by their set of parents
    from genealogy.models import Relationship as Rel
    from collections import defaultdict
    parent_groups = defaultdict(list)
    for rel in Rel.objects.filter(relationship_type='parent').select_related('person', 'relative'):
        if rel.relative.pk not in children_in_fam:
            parent_groups[rel.person.pk].append(rel.relative)

    for parent_pk, children in parent_groups.items():
        fam_counter += 1
        parent = Person.objects.get(pk=parent_pk)
        # Determine HUSB or WIFE based on gender
        if parent.gender == 'F':
            lines += [f'0 @F{fam_counter}@ FAM', f'1 WIFE @I{parent_pk}@']
        else:
            lines += [f'0 @F{fam_counter}@ FAM', f'1 HUSB @I{parent_pk}@']
        for child in children:
            lines.append(f'1 CHIL @I{child.pk}@')
            children_in_fam.add(child.pk)

    lines.append('0 TRLR')
    response = HttpResponse('\r\n'.join(lines), content_type='text/plain; charset=utf-8')
    response['Content-Disposition'] = 'attachment; filename="van_eeden_familie.ged"'
    return response


# ─── GEDCOM import ────────────────────────────────────────────────────────────

@login_required
def import_gedcom(request):
    profile = get_profile(request.user)
    if not profile.is_admin:
        return HttpResponseForbidden('Slegs beheerders kan GEDCOM-lêers invoer.')
    if request.method == 'POST':
        form = GedcomImportForm(request.POST, request.FILES)
        if form.is_valid():
            import tempfile, os
            from genealogy.management.commands.import_gedcom import (
                parse_gedcom, extract_individuals, extract_families
            )
            uploaded = request.FILES['gedcom_file']
            with tempfile.NamedTemporaryFile(delete=False, suffix='.ged') as tmp:
                for chunk in uploaded.chunks(): tmp.write(chunk)
                tmp_path = tmp.name
            try:
                records     = parse_gedcom(tmp_path)
                individuals = extract_individuals(records)
                families    = extract_families(records)
                xref_to_pk  = {}
                for xref, i in individuals.items():
                    parts  = i['given'].split()
                    first  = parts[0] if parts else 'Onbekend'
                    middle = ' '.join(parts[1:]) if len(parts) > 1 else ''
                    # Convert parsed dates back to GEDCOM strings
                    bd = _date_to_gedcom(i.get('birth_date'), i.get('birth_modifier',''))
                    dd = _date_to_gedcom(i.get('death_date'), i.get('death_modifier',''))
                    person = Person.objects.create(
                        first_name=first, middle_name=middle,
                        last_name=i['surname'] or 'Onbekend',
                        gender=i['sex'] if i['sex'] in ('M','F') else 'U',
                        birth_date=bd, birth_place=i.get('birth_place',''),
                        death_date=dd, death_place=i.get('death_place',''),
                        is_deceased=i.get('is_deceased', False),
                        notes=i.get('notes','').strip(),
                        is_root=i.get('is_root', False),
                        created_by=request.user,
                    )
                    xref_to_pk[xref] = person.pk
                for fam in families:
                    h = xref_to_pk.get(fam['husb'])
                    w = xref_to_pk.get(fam['wife'])
                    if h and w:
                        md = _date_to_gedcom(fam.get('marr_date'), '')
                        Marriage.objects.create(
                            person1=Person.objects.get(pk=h),
                            person2=Person.objects.get(pk=w),
                            marriage_date=md,
                            marriage_place=fam.get('marr_place',''),
                        )
                    parent_pk = h or w
                    if parent_pk:
                        parent = Person.objects.get(pk=parent_pk)
                        for cxref in fam.get('children', []):
                            cpk = xref_to_pk.get(cxref)
                            if cpk:
                                Relationship.objects.get_or_create(
                                    person=parent,
                                    relative=Person.objects.get(pk=cpk),
                                    defaults={'relationship_type': 'parent'},
                                )
                messages.success(request, f'{len(individuals)} mense ingevoer uit {uploaded.name}.')
                return redirect('genealogy:person_list')
            except Exception as e:
                messages.error(request, f'Invoer misluk: {e}')
            finally:
                os.unlink(tmp_path)
    else:
        form = GedcomImportForm()
    return render(request, 'genealogy/import_gedcom.html', {'form': form, 'profile': profile})


def _date_to_gedcom(date_obj, modifier):
    """Convert a Python date object (from the GEDCOM importer) to a GEDCOM string."""
    if not date_obj:
        return ''
    MONTHS_GED = ['JAN','FEB','MAR','APR','MAY','JUN',
        'JUL','AUG','SEP','OCT','NOV','DEC']
    try:
        day = date_obj.day
        month = MONTHS_GED[date_obj.month - 1]
        year = date_obj.year
        date_str = f'{day} {month} {year}'
        if modifier and modifier.upper() in ('BEF','AFT','EST','ABT','CAL'):
            return f'{modifier.upper()} {date_str}'
        return date_str
    except (AttributeError, IndexError):
        return str(date_obj) if date_obj else ''


# ─── Document auto-creation helpers ──────────────────────────────────────────

EVENT_DOCTYPE_MAP = {
    'birth':            'birth_certificate',
    'death':            'death_certificate',
    'baptism':          'baptism',
    'immigration':      'immigration',
    'emigration':       'emigration',
    'military_service': 'military',
    'graduation':       'graduation',
    'marriage':         'marriage_certificate',
    'other':            'other',
}

MARRIAGE_DOCTYPE_MAP = {
    'married':  'marriage_certificate',
    'divorced': 'divorce_paper',
    'annulled': 'annulment_certificate',
}

RELATION_DOCTYPE_MAP = {
    'adoptive_parent': 'adoption_paper',
    'guardian':        'guardianship_paper',
}


def _create_marriage_document(request, marriage):
    f = request.FILES.get('doc_file')
    if not f:
        return
    folder   = Document.MARRIAGE_FOLDER_MAP.get(marriage.status)
    if not folder:
        return
    doc_type = MARRIAGE_DOCTYPE_MAP.get(marriage.status, 'other')
    title    = request.POST.get('doc_title') or \
        f'{marriage.get_status_display()} — {marriage.person1.full_name} & {marriage.person2.full_name}'
    doc = Document(
        title=title,
        document_type=doc_type,
        description=request.POST.get('doc_description', ''),
        uploaded_by=request.user,
    )
    doc.file.field.upload_to = f'documents/{folder}/'
    doc.file = f
    doc.marriage = marriage
    doc.save()
    doc.people.set([marriage.person1, marriage.person2])


def _create_event_document(request, event):
    f = request.FILES.get('doc_file')
    if not f:
        return
    first_person = event.people.first()
    folder   = Document.EVENT_FOLDER_MAP.get(event.event_type, 'events/other')
    doc_type = EVENT_DOCTYPE_MAP.get(event.event_type, 'other')
    title    = request.POST.get('doc_title') or \
        f'{event.get_event_type_display()} — {event.title}'
    doc = Document(
        title=title,
        document_type=doc_type,
        description=request.POST.get('doc_description', ''),
        uploaded_by=request.user,
        event=event,
    )
    doc.file.field.upload_to = f'documents/{folder}/'
    doc.file = f
    doc.event = event
    doc.save()
    if first_person:
        doc.people.set([first_person])


def _create_relationship_document(request, relationship):
    f = request.FILES.get('doc_file')
    if not f:
        return
    folder   = Document.RELATION_FOLDER_MAP.get(relationship.relationship_type)
    if not folder:
        return
    doc_type = RELATION_DOCTYPE_MAP.get(relationship.relationship_type, 'other')
    title    = request.POST.get('doc_title') or \
        f'{relationship.get_relationship_type_display()} — {relationship.relative.full_name}'
    doc = Document(
        title=title,
        document_type=doc_type,
        description=request.POST.get('doc_description', ''),
        uploaded_by=request.user,
    )
    doc.file.field.upload_to = f'documents/{folder}/'
    doc.file = f
    doc.relationship = relationship
    doc.save()
    doc.people.set([relationship.relative])

def _create_person_document(request, person, doc_type):
    f = request.FILES.get(f'{doc_type}_doc_file')
    if not f:
        return
    folder = Document.EVENT_FOLDER_MAP.get(doc_type)
    if not folder:
        return

    # Find or create the corresponding event
    event_type = 'birth' if doc_type == 'birth' else 'death'
    event = Event.objects.filter(event_type=event_type, people=person).first()
    if not event:
        event = Event.objects.create(
            event_type=event_type,
            title=f'{person.full_name} — {"Geboorte" if doc_type == "birth" else "Sterfte"}',
            date=getattr(person, f'{doc_type}_date', ''),
            place=getattr(person, f'{doc_type}_place', ''),
        )
        event.people.add(person)

    title = request.POST.get(f'{doc_type}_doc_title') or \
        f'{person.full_name} — {"Geboortesertifikaat" if doc_type == "birth" else "Doodsertifikaat"}'
    doc = Document(
        title=title,
        document_type='birth_certificate' if doc_type == 'birth' else 'death_certificate',
        description=request.POST.get(f'{doc_type}_doc_description', ''),
        uploaded_by=request.user,
        event=event,
    )
    doc.file.field.upload_to = f'documents/{folder}/'
    doc.file = f
    doc.save()
    doc.people.set([person])


# ─── Document Search ──────────────────────────────────────────────────────────

def document_search(request):
    profile = get_profile(request.user)
    q            = request.GET.get('q', '').strip()
    doc_type     = request.GET.get('document_type', '')
    person_q     = request.GET.get('person', '').strip()
    date_from    = request.GET.get('date_from', '').strip()
    date_to      = request.GET.get('date_to', '').strip()

    documents = Document.objects.all()

    if q:
        documents = documents.filter(
            Q(title__icontains=q) |
            Q(description__icontains=q) |
            Q(source__icontains=q)
        )
    if doc_type:
        documents = documents.filter(document_type=doc_type)
    if person_q:
        documents = documents.filter(
            Q(people__first_name__icontains=person_q) |
            Q(people__last_name__icontains=person_q)
        ).distinct()
    if date_from:
        documents = documents.filter(date__gte=date_from)
    if date_to:
        documents = documents.filter(date__lte=date_to)

    return render(request, 'genealogy/document_search.html', {
        'documents': documents,
        'document_types': Document.DOCUMENT_TYPES,
        'profile': profile,
        'q': q,
        'doc_type': doc_type,
        'person_q': person_q,
        'date_from': date_from,
        'date_to': date_to,
        'count': documents.count(),
    })
