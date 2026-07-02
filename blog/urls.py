from django.urls import path
from . import views

app_name = 'blog'

urlpatterns = [
    path('',                          views.post_list,        name='post_list'),
    path('nuwe-plasing/',             views.post_create,      name='post_create'),
    path('konsepte/',                 views.drafts,           name='drafts'),
    path('kommentaar/keur-goed/',     views.approve_comments, name='approve_comments'),
    path('kategorie/<slug:slug>/',    views.category_view,    name='category'),
    path('etiket/<slug:slug>/',       views.tag_view,         name='tag'),
    path('<slug:slug>/',              views.post_detail,      name='post_detail'),
    path('<slug:slug>/wysig/',        views.post_edit,        name='post_edit'),
    path('<slug:slug>/verwyder/',     views.post_delete,      name='post_delete'),
]
