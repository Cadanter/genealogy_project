from django.urls import path
from . import views

app_name = 'genealogy'

urlpatterns = [
    # Auth
    path('teken-in/',    views.login_view,    name='login'),
    path('teken-uit/',   views.logout_view,   name='logout'),
    path('registreer/',  views.register_view, name='register'),

    # Public
    path('',                              views.dashboard,         name='dashboard'),
    path('mense/',                        views.person_list,       name='person_list'),
    path('mense/<int:pk>/',               views.person_detail,     name='person_detail'),
    path('mense/<int:pk>/stamboom/',      views.family_tree_data,  name='family_tree'),
    path('kaart/',                        views.map_view,          name='map'),
    path('geskiedenis/',                  views.audit_log,         name='audit_log'),
    path('uitvoer/gedcom/',               views.export_gedcom,     name='export_gedcom'),

    # Marriages
    path('huwelike/',                     views.marriage_list,     name='marriage_list'),
    path('huwelike/<int:pk>/',            views.marriage_detail,   name='marriage_detail'),
    path('huwelike/voeg-by/',             views.marriage_create,   name='marriage_create'),
    path('huwelike/<int:pk>/wysig/',      views.marriage_edit,     name='marriage_edit'),
    path('huwelike/<int:pk>/verwyder/',   views.marriage_delete,   name='marriage_delete'),

    # Relationships
    path('verhoudings/',                  views.relationship_list,   name='relationship_list'),
    path('verhoudings/<int:pk>/',         views.relationship_detail, name='relationship_detail'),
    path('verhoudings/voeg-by/',          views.relationship_create, name='relationship_create'),
    path('verhoudings/<int:pk>/wysig/',   views.relationship_edit,   name='relationship_edit'),
    path('verhoudings/<int:pk>/verwyder/', views.relationship_delete, name='relationship_delete'),

    # Documents
    path('dokumente/',                    views.document_list,     name='document_list'),
    path('dokumente/soek/',               views.document_search,   name='document_search'),
    path('dokumente/<int:pk>/',           views.document_detail,   name='document_detail'),
    path('dokumente/voeg-by/',            views.document_create,   name='document_create'),
    path('dokumente/<int:pk>/wysig/',     views.document_edit,     name='document_edit'),
    path('dokumente/<int:pk>/verwyder/',  views.document_delete,   name='document_delete'),

    # Events
    path('gebeure/',                      views.event_list,        name='event_list'),
    path('gebeure/<int:pk>/',             views.event_detail,      name='event_detail'),
    path('gebeure/voeg-by/',              views.event_create,      name='event_create'),
    path('gebeure/<int:pk>/wysig/',       views.event_edit,        name='event_edit'),
    path('gebeure/<int:pk>/verwyder/',    views.event_delete,      name='event_delete'),

    # Requires login
    path('mense/voeg-by/',                views.person_create,     name='person_create'),
    path('mense/<int:pk>/wysig/',         views.person_edit,       name='person_edit'),
    path('mense/<int:pk>/verwyder/',      views.person_delete,     name='person_delete'),
    path('mense/<int:pk>/koppel-kind/',   views.person_add_child,  name='person_add_child'),
    path('mense/<int:pk>/voeg-gade-by/',  views.person_add_spouse, name='person_add_spouse'),
    path('invoer/gedcom/',                views.import_gedcom,     name='import_gedcom'),

    # Admin only
    path('lede/',                              views.members_list,   name='members_list'),
    path('lede/<int:user_id>/keur-goed/',      views.approve_member, name='approve_member'),
    path('lede/<int:user_id>/wysig/',          views.member_edit,    name='member_edit'),
    path('lede/<int:user_id>/verwyder/',       views.member_delete,  name='member_delete'),
    path('wysigings/',                         views.pending_edits,  name='pending_edits'),
    path('wysigings/<int:edit_id>/hersien/',   views.review_edit,    name='review_edit'),
]
