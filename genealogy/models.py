from django.db import models
from django.urls import reverse
from django.contrib.auth.models import User


# ─── User Profile & Roles ────────────────────────────────────────────────────

class UserProfile(models.Model):
    ROLE_CHOICES = [
        ('pending', 'Hangende Beoordeling'),
        ('viewer',  'Kyker'),
        ('trusted', 'Vertroude Lid'),
        ('admin',   'Administrateur'),
    ]
    user        = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    role        = models.CharField(max_length=10, choices=ROLE_CHOICES, default='pending')
    bio         = models.TextField(blank=True)
    joined      = models.DateTimeField(auto_now_add=True)
    approved_by = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True,
                    related_name='approved_profiles')
    approved_at = models.DateTimeField(null=True, blank=True)

    def __str__(self): return f'{self.user.username} ({self.get_role_display()})'

    @property
    def is_admin(self):   return self.role == 'admin'
    @property
    def is_trusted(self): return self.role in ('trusted', 'admin')
    @property
    def is_approved(self):return self.role in ('viewer', 'trusted', 'admin')
    @property
    def can_edit(self):   return self.role in ('trusted', 'admin')
    @property
    def can_delete(self): return self.role == 'admin'


# ─── Core Genealogy Models ────────────────────────────────────────────────────

class Person(models.Model):
    GENDER_CHOICES = [('M','Manlik'),('F','Vroulik'),('O','Ander'),('U','Onbekend')]

    first_name  = models.CharField(max_length=100)
    middle_name = models.CharField(max_length=100, blank=True)
    last_name   = models.CharField(max_length=100)
    maiden_name = models.CharField(max_length=100, blank=True)
    gender      = models.CharField(max_length=1, choices=GENDER_CHOICES, default='U')
    photo       = models.ImageField(upload_to='people/photos/', blank=True, null=True)

    birth_date  = models.CharField(max_length=100, blank=True,
                    help_text='GEDCOM datum, bv. BEF 15 JAN 1900')
    birth_place = models.CharField(max_length=200, blank=True)
    death_date  = models.CharField(max_length=100, blank=True,
                    help_text='GEDCOM datum, bv. AFT 1950')
    death_place = models.CharField(max_length=200, blank=True)
    is_deceased = models.BooleanField(default=False)
    is_root     = models.BooleanField(default=False, help_text='Stam-ouer van die boom (a1)')

    biography   = models.TextField(blank=True)
    notes       = models.TextField(blank=True)
    created_at  = models.DateTimeField(auto_now_add=True)
    updated_at  = models.DateTimeField(auto_now=True)
    created_by  = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True,
                    related_name='created_people')

    birth_lat   = models.FloatField(null=True, blank=True)
    birth_lng   = models.FloatField(null=True, blank=True)
    death_lat   = models.FloatField(null=True, blank=True)
    death_lng   = models.FloatField(null=True, blank=True)

    class Meta:
        ordering = ['first_name', 'last_name']
        verbose_name_plural = 'Mense'

    def __str__(self): return self.full_name

    @property
    def full_name(self):
        parts = [self.first_name]
        if self.middle_name: parts.append(self.middle_name)
        parts.append(self.last_name)
        return ' '.join(parts)

    def get_absolute_url(self):
        return reverse('genealogy:person_detail', kwargs={'pk': self.pk})

    def get_parents(self):
        return [r.person for r in self.child_relationships.filter(relationship_type='parent')]

    def get_children(self):
        return [r.relative for r in self.person_relationships.filter(relationship_type='parent')]

    def get_siblings(self):
        ids = set()
        for p in self.get_parents():
            for c in p.get_children():
                if c.pk != self.pk: ids.add(c.pk)
        return Person.objects.filter(pk__in=ids)

    def get_spouses(self):
        spouses = []
        for m in Marriage.objects.filter(person1=self):
            spouses.append({'person': m.person2, 'marriage': m})
        for m in Marriage.objects.filter(person2=self):
            spouses.append({'person': m.person1, 'marriage': m})
        return spouses

    @property
    def age(self):
        from .gedcom_dates import calc_age
        return calc_age(self.birth_date, self.death_date)

    @property
    def birth_date_display(self):
        from .gedcom_dates import gedcom_to_display
        return gedcom_to_display(self.birth_date)

    @property
    def death_date_display(self):
        from .gedcom_dates import gedcom_to_display
        return gedcom_to_display(self.death_date)

    @property
    def birth_year(self):
        from .gedcom_dates import parse_gedcom_date
        p = parse_gedcom_date(self.birth_date)
        return p.get('year') if p else None

    @property
    def death_year(self):
        from .gedcom_dates import parse_gedcom_date
        p = parse_gedcom_date(self.death_date)
        return p.get('year') if p else None


class Relationship(models.Model):
    RELATIONSHIP_TYPES = [
        ('parent',          'Ouer'),
        ('adoptive_parent', 'Aangenome Ouer'),
        ('step_parent',     'Stief Ouer'),
        ('guardian',        'Voog'),
    ]
    person            = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='person_relationships')
    relative          = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='child_relationships')
    relationship_type = models.CharField(max_length=20, choices=RELATIONSHIP_TYPES, default='parent')
    notes             = models.TextField(blank=True)

    class Meta:
        unique_together = ('person', 'relative', 'relationship_type')

    def __str__(self):
        return f'{self.person} is {self.get_relationship_type_display()} of {self.relative}'

    def get_absolute_url(self):
        return reverse('genealogy:relationship_detail', kwargs={'pk': self.pk})


class Marriage(models.Model):
    STATUS_CHOICES = [
        ('married','Getroud'),
        ('divorced','Geskei'),
        ('widowed','Nagelaat'),
        ('separated','Vervreemd'),
        ('annulled','Nietig Verklaar'),
    ]

    person1        = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='marriages_as_person1')
    person2        = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='marriages_as_person2')
    marriage_date  = models.CharField(max_length=100, blank=True,
                       help_text='GEDCOM datum, bv. 15 JAN 1920')
    marriage_place = models.CharField(max_length=200, blank=True)
    end_date       = models.CharField(max_length=100, blank=True,
                       help_text='GEDCOM datum')
    end_place      = models.CharField(max_length=200, blank=True)
    status         = models.CharField(max_length=20, choices=STATUS_CHOICES, default='married')
    notes          = models.TextField(blank=True)

    class Meta:
        ordering = ['marriage_date']

    def __str__(self):
        return f'{self.person1} & {self.person2}'

    def get_absolute_url(self):
        return reverse('genealogy:marriage_detail', kwargs={'pk': self.pk})

    @property
    def marriage_date_display(self):
        from .gedcom_dates import gedcom_to_display
        return gedcom_to_display(self.marriage_date)

    @property
    def end_date_display(self):
        from .gedcom_dates import gedcom_to_display
        return gedcom_to_display(self.end_date)


class Document(models.Model):
    DOCUMENT_TYPES = [
        ('birth_certificate', 'Geboorte Sertifikaat'),
        ('death_certificate', 'Dood Sertifikaat'),
        ('marriage_certificate', 'Huwelik Sertifikaat'),
        ('divorce_paper', 'Skeibrief'),
        ('annulment_certificate', 'Nietigverklaring Sertifikaat'),
        ('adoption_paper', 'Aanneming Papiere'),
        ('guardianship_paper', 'Voogdyskap Papiere'),
        ('baptism', 'Doop Sertifikaat'),
        ('immigration', 'Immigrasie Rekord'),
        ('emigration', 'Emigrasie Rekord'),
        ('military', 'Militêre Rekord'),
        ('graduation', 'Diploma of Graad'),
        ('census', 'Sensus Rekord'),
        ('photo', 'Foto'),
        ('letter', 'Brief'),
        ('will', 'Testament'),
        ('other', 'Ander'),
    ]

    # Folder mappings for auto-created documents
    EVENT_FOLDER_MAP = {
        'birth':          'events/birth_certificates',
        'death':          'events/death_certificates',
        'baptism':        'events/baptism',
        'immigration':    'events/immigration',
        'emigration':     'events/emigration',
        'military_service': 'events/military_service',
        'graduation':     'events/graduation',
        'other':          'events/other',
    }
    MARRIAGE_FOLDER_MAP = {
        'married':  'marital_status/marriage_certificates',
        'divorced': 'marital_status/divorce_papers',
        'annulled': 'marital_status/annulment_certificates',
    }
    RELATION_FOLDER_MAP = {
        'adoptive_parent': 'relations/adoption_papers',
        'guardian':        'relations/guardianship_papers',
    }

    title         = models.CharField(max_length=200)
    document_type = models.CharField(max_length=30, choices=DOCUMENT_TYPES, default='other')
    file          = models.FileField(upload_to='documents/', blank=True, null=True)
    image         = models.ImageField(upload_to='documents/images/', blank=True, null=True)
    description   = models.TextField(blank=True)
    date          = models.CharField(max_length=100, blank=True,
                      help_text='GEDCOM datum, bv. 12/08/1923 of BEF/AFT/EST/ABT 1900')
    source        = models.CharField(max_length=300, blank=True)
    people        = models.ManyToManyField(Person, related_name='documents', blank=True)
    event         = models.ForeignKey('Event', on_delete=models.SET_NULL, null=True, blank=True,
                      related_name='documents')
    marriage      = models.ForeignKey('Marriage', on_delete=models.SET_NULL, null=True, blank=True,
                      related_name='documents')
    relationship  = models.ForeignKey('Relationship', on_delete=models.SET_NULL, null=True, blank=True,
                      related_name='documents')
    created_at    = models.DateTimeField(auto_now_add=True)
    uploaded_by   = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True,
                      related_name='documents')

    class Meta:
        ordering = ['-created_at', 'title']

    def __str__(self): return self.title

    def get_absolute_url(self):
        return reverse('genealogy:document_detail', kwargs={'pk': self.pk})

    @property
    def date_display(self):
        from .gedcom_dates import gedcom_to_display
        return gedcom_to_display(self.date)


class Event(models.Model):
    EVENT_TYPES = [
        ('birth','Geboorte'),
        ('death','Sterfte'),
        ('baptism','Doop'),
        ('immigration','Immigrasie'),
        ('emigration','Emigrasie'),
        ('military_service','Militêre Diens'),
        ('graduation','Graduering'),
        ('other','Ander'),
    ]
    title       = models.CharField(max_length=200)
    event_type  = models.CharField(max_length=20, choices=EVENT_TYPES, default='other')
    date        = models.CharField(max_length=100, blank=True,
                    help_text='GEDCOM datum, bv. 12/08/1923 of BEF/AFT/EST/ABT 1900')
    place       = models.CharField(max_length=200, blank=True)
    description = models.TextField(blank=True)
    people      = models.ManyToManyField(Person, related_name='events', blank=True)

    class Meta:
        ordering = ['date']

    def __str__(self): return self.title

    def get_absolute_url(self):
        return reverse('genealogy:event_detail', kwargs={'pk': self.pk})

    @property
    def date_display(self):
        from .gedcom_dates import gedcom_to_display
        return gedcom_to_display(self.date)


# ─── Audit & Proposed Edits ──────────────────────────────────────────────────

class AuditLog(models.Model):
    ACTION_CHOICES = [('create','Geskep'),('update','Gewysig'),('delete','Verwyder')]
    user        = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='audit_logs')
    action      = models.CharField(max_length=10, choices=ACTION_CHOICES)
    model_name  = models.CharField(max_length=50)
    object_id   = models.IntegerField(null=True, blank=True)
    object_repr = models.CharField(max_length=200)
    changes     = models.JSONField(default=dict, blank=True)
    timestamp   = models.DateTimeField(auto_now_add=True)
    note        = models.TextField(blank=True)

    class Meta:
        ordering = ['-timestamp']

    def __str__(self):
        return f'{self.user} {self.action} {self.object_repr} @ {self.timestamp:%Y-%m-%d %H:%M}'


class PendingEdit(models.Model):
    STATUS_CHOICES = [('pending','Hangende Beoordeling'),('approved','Goedgekeur'),('rejected','Verwerp')]
    ACTION_CHOICES = [('create','Nuwe Rekord'),('update','Wysig Rekord')]
    proposed_by   = models.ForeignKey(User, on_delete=models.CASCADE, related_name='proposed_edits')
    action        = models.CharField(max_length=10, choices=ACTION_CHOICES)
    model_name    = models.CharField(max_length=50)
    object_id     = models.IntegerField(null=True, blank=True)
    object_repr   = models.CharField(max_length=200)
    proposed_data = models.JSONField(default=dict)
    field_changes = models.JSONField(default=dict, blank=True)
    note          = models.TextField(blank=True)
    status        = models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending')
    reviewed_by   = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True,
                      related_name='reviewed_edits')
    reviewed_at   = models.DateTimeField(null=True, blank=True)
    review_note   = models.TextField(blank=True)
    submitted_at  = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-submitted_at']

    def __str__(self):
        return f'{self.proposed_by} proposes {self.action} on {self.object_repr}'
