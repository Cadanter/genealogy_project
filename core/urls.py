from django.urls import path
from . import views

urlpatterns = [
    path('', views.landing, name='landing'),
    path('handleiding/', views.user_manual, name='user_manual'),
]
