"""
Management command to import a GEDCOM file.
Usage: python manage.py import_gedcom path/to/file.ged --user=username
"""
import re
from datetime import datetime
from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth.models import User
from genealogy.models import Person, Relationship, Marriage


MONTH_MAP = {
    'JAN': 1, 'FEB': 2, 'MAR': 3, 'APR': 4, 'MAY': 5, 'JUN': 6,
    'JUL': 7, 'AUG': 8, 'SEP': 9, 'OCT': 10, 'NOV': 11, 'DEC': 12,
}


def parse_gedcom_date(date_str):
    """Try to parse a GEDCOM date string into a Python date."""
    if not date_str:
        return None
    date_str = date_str.strip().upper()
    # Remove qualifiers like ABT, BEF, AFT, EST
    date_str = re.sub(r'^(ABT|BEF|AFT|EST|CAL|INT)\s+', '', date_str)
    # Try DD MON YYYY
    m = re.match(r'(\d{1,2})\s+([A-Z]{3})\s+(\d{4})', date_str)
    if m:
        try:
            return datetime(int(m.group(3)), MONTH_MAP.get(m.group(2), 1), int(m.group(1))).date()
        except ValueError:
            pass
    # Try MON YYYY
    m = re.match(r'([A-Z]{3})\s+(\d{4})', date_str)
    if m:
        try:
            return datetime(int(m.group(2)), MONTH_MAP.get(m.group(1), 1), 1).date()
        except ValueError:
            pass
    # Try YYYY
    m = re.match(r'(\d{4})$', date_str)
    if m:
        try:
            return datetime(int(m.group(1)), 1, 1).date()
        except ValueError:
            pass
    return None


def parse_gedcom(filepath):
    """Parse a GEDCOM file into a dict of records."""
    records = {}
    current_id = None
    current_tag = None
    current_sub = None

    with open(filepath, encoding='utf-8', errors='replace') as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split(' ', 2)
            if len(parts) < 2:
                continue
            level = parts[0]
            rest = parts[1:]

            if level == '0':
                if len(rest) >= 2 and rest[0].startswith('@'):
                    current_id = rest[0]
                    tag = rest[1]
                    records[current_id] = {'_tag': tag, '_lines': []}
                    current_tag = None
                    current_sub = None
            elif current_id:
                tag = rest[0]
                value = rest[1] if len(rest) > 1 else ''
                records[current_id]['_lines'].append((level, tag, value))

    return records


def extract_individuals(records):
    """Extract individual people from parsed GEDCOM records."""
    individuals = {}
    for xref, rec in records.items():
        if rec['_tag'] != 'INDI':
            continue
        indi = {'xref': xref, 'given': '', 'surname': '', 'sex': 'U',
                'birth_date': None, 'birth_place': '', 'death_date': None,
                'death_place': '', 'is_deceased': False, 'notes': '',
                'henry': '', 'is_root': False}
        in_birt = in_deat = False
        for level, tag, value in rec['_lines']:
            if level == '1':
                in_birt = tag == 'BIRT'
                in_deat = tag == 'DEAT'
                if tag == 'NAME':
                    parts = value.split('/')
                    indi['given'] = parts[0].strip()
                    if len(parts) > 1:
                        indi['surname'] = parts[1].strip()
                elif tag == 'SEX':
                    indi['sex'] = value.strip()
                elif tag == 'DEAT':
                    indi['is_deceased'] = True
                elif tag in ('NOTE', 'CONC', 'CONT'):
                    indi['notes'] += value + ' '
                elif tag == '_HENRY':
                    indi['henry'] = value.strip()
                elif tag == '_ROOT':
                    indi['is_root'] = value.strip().upper() == 'Y'
            elif level == '2':
                if in_birt:
                    if tag == 'DATE':
                        indi['birth_date'] = value.strip()
                    elif tag == 'PLAC':
                        indi['birth_place'] = value
                elif in_deat:
                    indi['is_deceased'] = True
                    if tag == 'DATE':
                        indi['death_date'] = value.strip()
                    elif tag == 'PLAC':
                        indi['death_place'] = value
        individuals[xref] = indi
    return individuals


def extract_families(records):
    """Extract family (FAM) records."""
    families = []
    for xref, rec in records.items():
        if rec['_tag'] != 'FAM':
            continue
        fam = {'husb': None, 'wife': None, 'children': [],
               'marr_date': '', 'marr_place': '', 'status': 'married'}
        in_marr = False
        for level, tag, value in rec['_lines']:
            if level == '1':
                in_marr = tag == 'MARR'
                if tag == 'HUSB':
                    fam['husb'] = value
                elif tag == 'WIFE':
                    fam['wife'] = value
                elif tag == 'CHIL':
                    fam['children'].append(value)
                elif tag == '_STATUS':
                    fam['status'] = value.strip()
            elif level == '2' and in_marr:
                if tag == 'DATE':
                    # Store as raw GEDCOM string, not parsed date
                    fam['marr_date'] = value.strip()
                elif tag == 'PLAC':
                    fam['marr_place'] = value
        families.append(fam)
    return families


class Command(BaseCommand):
    help = 'Import a GEDCOM (.ged) file into the database'

    def add_arguments(self, parser):
        parser.add_argument('file', type=str, help='Path to the .ged file')
        parser.add_argument('--user', type=str, required=True, help='Username to assign records to')
        parser.add_argument('--dry-run', action='store_true', help='Parse without saving')

    def handle(self, *args, **options):
        try:
            user = User.objects.get(username=options['user'])
        except User.DoesNotExist:
            raise CommandError(f"User '{options['user']}' not found.")

        self.stdout.write(f'Parsing {options["file"]}...')
        records = parse_gedcom(options['file'])
        individuals = extract_individuals(records)
        families = extract_families(records)

        self.stdout.write(f'Found {len(individuals)} individuals, {len(families)} families.')

        if options['dry_run']:
            for xref, i in list(individuals.items())[:5]:
                self.stdout.write(f'  {i["given"]} {i["surname"]} b.{i["birth_date"]}')
            return

        # Create Person objects
        xref_to_pk = {}
        created = 0
        for xref, i in individuals.items():
            given_parts = i['given'].split()
            first = given_parts[0] if given_parts else 'Unknown'
            middle = ' '.join(given_parts[1:]) if len(given_parts) > 1 else ''
            person = Person.objects.create(
                first_name=first,
                middle_name=middle,
                last_name=i['surname'] or 'Unknown',
                gender=i['sex'] if i['sex'] in ('M', 'F') else 'U',
                birth_date=i['birth_date'] or '',
                birth_place=i['birth_place'] or '',
                death_date=i['death_date'] or '',
                death_place=i['death_place'] or '',
                is_deceased=i['is_deceased'],
                notes=i['notes'].strip(),
                is_root=i.get('is_root', False),
                created_by=user,
            )
            xref_to_pk[xref] = person.pk
            created += 1

        # Create family relationships
        marriages_created = 0
        relationships_created = 0
        for fam in families:
            husb_pk = xref_to_pk.get(fam['husb'])
            wife_pk = xref_to_pk.get(fam['wife'])

            if husb_pk and wife_pk:
                p1 = Person.objects.get(pk=husb_pk)
                p2 = Person.objects.get(pk=wife_pk)
                Marriage.objects.create(
                    person1=p1, person2=p2,
                    marriage_date=fam['marr_date'],
                    marriage_place=fam['marr_place'],
                    status=fam.get('status', 'married'),
                )
                marriages_created += 1

            # Link children to BOTH parents
            for child_xref in fam['children']:
                child_pk = xref_to_pk.get(child_xref)
                if not child_pk:
                    continue
                child = Person.objects.get(pk=child_pk)
                for parent_pk in [husb_pk, wife_pk]:
                    if parent_pk:
                        parent = Person.objects.get(pk=parent_pk)
                        _, created = Relationship.objects.get_or_create(
                            person=parent, relative=child,
                            defaults={'relationship_type': 'parent'}
                        )
                        if created:
                            relationships_created += 1

        self.stdout.write(self.style.SUCCESS(
            f'✓ Imported {created} people, {marriages_created} marriages, {relationships_created} parent–child links.'
        ))
