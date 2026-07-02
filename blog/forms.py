from django import forms
from .models import Post, Comment, Category, Tag


class CommentForm(forms.ModelForm):
    class Meta:
        model   = Comment
        fields  = ['author_name', 'author_email', 'body']
        widgets = {
            'author_name':  forms.TextInput(attrs={'placeholder': 'U naam / Your name'}),
            'author_email': forms.EmailInput(attrs={'placeholder': 'U e-pos / Your email (nie gepubliseer / not published)'}),
            'body':         forms.Textarea(attrs={'rows': 4, 'placeholder': 'U kommentaar / Your comment…'}),
        }
        labels = {
            'author_name':  'Naam / Name',
            'author_email': 'E-pos / Email',
            'body':         'Kommentaar / Comment',
        }


class PostForm(forms.ModelForm):
    class Meta:
        model  = Post
        fields = [
            'title', 'title_af', 'slug', 'category', 'tags',
            'body', 'body_af', 'excerpt', 'excerpt_af',
            'cover_image', 'language', 'status', 'published_at',
        ]
        widgets = {
            'body':         forms.Textarea(attrs={'rows': 16}),
            'body_af':      forms.Textarea(attrs={'rows': 16}),
            'excerpt':      forms.Textarea(attrs={'rows': 3}),
            'excerpt_af':   forms.Textarea(attrs={'rows': 3}),
            'tags':         forms.CheckboxSelectMultiple(),
            'published_at': forms.DateTimeInput(attrs={'type': 'datetime-local'}),
        }
