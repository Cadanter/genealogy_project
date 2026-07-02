from django.contrib import admin
from .models import Post, Category, Tag, Comment


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display  = ['title', 'author', 'category', 'status', 'published_at']
    list_filter   = ['status', 'language', 'category']
    search_fields = ['title', 'title_af', 'body']
    prepopulated_fields = {'slug': ('title',)}
    filter_horizontal = ['tags']


@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}


@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    prepopulated_fields = {'slug': ('name',)}


@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display  = ['author_name', 'post', 'approved', 'created_at']
    list_filter   = ['approved']
    list_editable = ['approved']
