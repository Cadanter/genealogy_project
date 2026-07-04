from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Person, Relationship, Marriage, Document, Event, UserProfile


class RegisterForm(UserCreationForm):
    email = forms.EmailField(required=True)
    bio   = forms.CharField(
        widget=forms.Textarea(attrs={'rows': 3}),
        label='Hoe is u aan die van Eeden-familie verbonde?',
        help_text='Dit help die beheerder om u lidmaatskap te bevestig.',
    )
    class Meta:
        model  = User
        fields = ['username', 'first_name', 'last_name', 'email', 'password1', 'password2']
        labels = {
            'username': 'Gebruikersnaam',
            'first_name': 'Voornaam',
            'last_name': 'Van',
            'email': 'E-pos',
            'password1': 'Wagwoord',
            'password2': 'Bevestig wagwoord',
        }

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data['email']
        if commit:
            user.save()
            UserProfile.objects.create(user=user, bio=self.cleaned_data['bio'], role='pending')
        return user


class PersonForm(forms.ModelForm):
    class Meta:
        model  = Person
        fields = [
            'first_name', 'middle_name', 'last_name', 'maiden_name',
            'gender', 'photo',
            'birth_date', 'birth_place',
            'is_deceased', 'death_date', 'death_place',
            'biography', 'notes',
        ]
        labels = {
            'first_name': 'Voornaam',
            'middle_name': 'Middelnaam',
            'last_name': 'Van',
            'maiden_name': 'Nooiensvan',
            'gender': 'Geslag',
            'photo': 'Foto',
            'birth_date': 'Geboortedatum',
            'birth_place': 'Geboorteland',
            'is_deceased': 'Is oorlede',
            'death_date': 'Sterftedatum',
            'death_place': 'Sterfteplek',
            'biography': 'Biografie',
            'notes': 'Notas',
        }
        widgets = {
            'birth_date': forms.HiddenInput(),
            'death_date': forms.HiddenInput(),
            'biography':  forms.Textarea(attrs={'rows': 4}),
            'notes':      forms.Textarea(attrs={'rows': 3}),
        }


class ProposePersonForm(forms.ModelForm):
    note = forms.CharField(
        widget=forms.Textarea(attrs={'rows': 2}),
        required=False,
        label='Waarom stel u hierdie wysiging voor?',
    )
    class Meta:
        model  = Person
        fields = [
            'first_name', 'middle_name', 'last_name', 'maiden_name',
            'gender', 'birth_date', 'birth_place',
            'is_deceased', 'death_date', 'death_place',
            'biography', 'notes',
        ]
        labels = {
            'first_name': 'Voornaam',
            'middle_name': 'Middelnaam',
            'last_name': 'Van',
            'maiden_name': 'Nooiensvan',
            'gender': 'Geslag',
            'birth_date': 'Geboortedatum',
            'birth_place': 'Geboorteland',
            'is_deceased': 'Is oorlede',
            'death_date': 'Sterftedatum',
            'death_place': 'Sterfteplek',
            'biography': 'Biografie',
            'notes': 'Notas',
        }
        widgets = {
            'birth_date': forms.HiddenInput(),
            'death_date': forms.HiddenInput(),
            'biography':  forms.Textarea(attrs={'rows': 4}),
            'notes':      forms.Textarea(attrs={'rows': 3}),
        }


class RelationshipForm(forms.ModelForm):
    class Meta:
        model  = Relationship
        fields = ['person', 'relative', 'relationship_type', 'notes']
        labels = {
            'person': 'Persoon',
            'relative': 'Familielid',
            'relationship_type': 'Verwantskap',
            'notes': 'Notas',
        }
        widgets = {'notes': forms.Textarea(attrs={'rows': 2})}


class MarriageForm(forms.ModelForm):
    class Meta:
        model  = Marriage
        fields = ['person1', 'person2', 'marriage_date', 'marriage_place',
                  'end_date', 'end_place', 'status', 'notes']
        labels = {
            'person1': 'Persoon 1',
            'person2': 'Persoon 2',
            'marriage_date': 'Huwelik datum',
            'marriage_place': 'Huwelik plek',
            'end_date': 'Eind datum',
            'end_place': 'Eind plek',
            'status': 'Status',
            'notes': 'Notas',
        }
        widgets = {
            'marriage_date': forms.HiddenInput(),
            'end_date':      forms.HiddenInput(),
            'notes':         forms.Textarea(attrs={'rows': 2}),
        }


class DocumentForm(forms.ModelForm):
    class Meta:
        model  = Document
        fields = ['title', 'document_type', 'file', 'image', 'description', 'date', 'source', 'people']
        labels = {
            'title': 'Titel',
            'document_type': 'Dokumenttipe',
            'file': 'Lêer',
            'image': 'Beeld',
            'description': 'Beskrywing',
            'date': 'Datum',
            'source': 'Bron',
            'people': 'Mense',
        }
        widgets = {
            'file':        forms.FileInput(),
            'image':       forms.FileInput(),
            'date':        forms.TextInput(attrs={'placeholder': 'bv. 1923, ABT 1900'}),
            'description': forms.Textarea(attrs={'rows': 3}),
            'people':      forms.CheckboxSelectMultiple(),
        }


class EventForm(forms.ModelForm):
    class Meta:
        model  = Event
        fields = ['title', 'event_type', 'date', 'place', 'description', 'people']
        labels = {
            'title': 'Titel',
            'event_type': 'Gebeurtenis',
            'date': 'Datum',
            'place': 'Plek',
            'description': 'Beskrywing',
            'people': 'Mense',
        }
        widgets = {
            'date':        forms.HiddenInput(),
            'description': forms.Textarea(attrs={'rows': 3}),
            'people':      forms.CheckboxSelectMultiple(),
        }


class SearchForm(forms.Form):
    query           = forms.CharField(max_length=200, required=False,
                        widget=forms.TextInput(attrs={'placeholder': 'Soek naam of plek…'}))
    gender          = forms.ChoiceField(choices=[('', 'Enige geslag')] + Person.GENDER_CHOICES, required=False)
    birth_year_from = forms.IntegerField(required=False,
                        widget=forms.NumberInput(attrs={'placeholder': 'Gebore van'}))
    birth_year_to   = forms.IntegerField(required=False,
                        widget=forms.NumberInput(attrs={'placeholder': 'Gebore tot'}))


class GedcomImportForm(forms.Form):
    gedcom_file = forms.FileField(label='GEDCOM-lêer (.ged)')


class EditNoteForm(forms.Form):
    note = forms.CharField(required=False,
        widget=forms.TextInput(attrs={'placeholder': 'Kort opsomming van hierdie wysiging (opsioneel)'}),
        label='Wysigingsopsomming')
