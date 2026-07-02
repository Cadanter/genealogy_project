# Danie van Eeden — Persoonlike Webtuiste

Een Django-projek met drie aparte toepassings:

| URL | Toepassing | Beskrywing |
|-----|-----------|------------|
| `/` | `core` | Tuisbladsy — bio en skakels |
| `/blog/` | `blog` | Volledige bloeiblog met kategorieë, etikette en kommentaar |
| `/argief/` | `genealogy` | Van Eeden Familiegeskiedenisargief |

## Opstelling / Setup

```bash
python -m venv venv
source venv/bin/activate        # Windows: venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py make_admin <jou-gebruikersnaam>
python manage.py runserver
```

Open http://127.0.0.1:8000/

## Foto byvoeg / Adding your photo

Place your photo at:
```
core/static/core/img/danie.jpg
```

Then in `core/templates/core/landing.html`, replace:
```html
<span class="avatar-placeholder">D</span>
```
with:
```html
<img src="{% static 'core/img/danie.jpg' %}" alt="Danie van Eeden">
```

## Blog gebruik / Blog usage

- **Nuwe plasing**: Teken in as `is_staff` gebruiker → klik "+ Nuwe plasing" in die navigasie
- **Konsepte**: Plasings met status "Konsep" is slegs vir jou sigbaar
- **Kommentaar**: Alle kommentare wag op goedkeuring voor publikasie
- **Tweetalig**: Elke plasing kan 'n Afrikaanse én Engelse weergawe hê — lesers kan wissel

## Argief gebruik / Archive usage

- **Rol-stelsel**: Admin → Vertroude lid → Kyker → Hangende
- Besoekers kan die argief sonder aanmelding blaai
- Nuwe lede registreer en wag op admin-goedkeuring
- Vertroude lede wysig direk; Kykers stel wysigings voor

## Administrateuse opdragte / Admin commands

```bash
# Promoveer 'n gebruiker tot argief-admin
python manage.py make_admin gebruikersnaam

# Voer 'n GEDCOM-lêer in
python manage.py import_gedcom lêer.ged --user=gebruikersnaam
```

## Projekstruktuur / Project structure

```
danie/
├── config/               # Instellings, hoof-URLs, wsgi
├── core/                 # Tuisbladsy
│   ├── static/core/css/landing.css
│   └── templates/core/landing.html
├── blog/                 # Bloeiblog
│   ├── models.py         # Post, Category, Tag, Comment
│   ├── views.py
│   ├── static/blog/css/blog.css
│   └── templates/blog/
├── genealogy/            # Van Eeden Familieargief
│   ├── models.py
│   ├── views.py
│   ├── static/genealogy/css/
│   └── templates/genealogy/
├── manage.py
└── requirements.txt
```
