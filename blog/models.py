from django.db import models
from django.contrib.auth.models import User
from django.urls import reverse
from django.utils.text import slugify


class Category(models.Model):
    name    = models.CharField(max_length=80)
    name_af = models.CharField(max_length=80, blank=True, verbose_name='Naam (Afrikaans)')
    slug    = models.SlugField(unique=True)
    description = models.TextField(blank=True)

    class Meta:
        verbose_name_plural = 'Categories'
        ordering = ['name']

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('blog:category', kwargs={'slug': self.slug})


class Tag(models.Model):
    name = models.CharField(max_length=50)
    slug = models.SlugField(unique=True)

    class Meta:
        ordering = ['name']

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.name)
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('blog:tag', kwargs={'slug': self.slug})


class Post(models.Model):
    STATUS_CHOICES = [
        ('draft',     'Konsep / Draft'),
        ('published', 'Gepubliseer / Published'),
    ]
    LANG_CHOICES = [
        ('af', 'Afrikaans'),
        ('en', 'English'),
        ('both', 'Beide / Both'),
    ]

    title       = models.CharField(max_length=200)
    title_af    = models.CharField(max_length=200, blank=True, verbose_name='Titel (Afrikaans)')
    slug        = models.SlugField(unique=True, max_length=220)
    author      = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='posts')
    category    = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True, related_name='posts')
    tags        = models.ManyToManyField(Tag, blank=True, related_name='posts')

    # Content — primary and optional Afrikaans version
    body        = models.TextField()
    body_af     = models.TextField(blank=True, verbose_name='Inhoud (Afrikaans)')

    excerpt     = models.TextField(blank=True, help_text='Short summary shown on the list page')
    excerpt_af  = models.TextField(blank=True, verbose_name='Uittreksel (Afrikaans)')

    cover_image = models.ImageField(upload_to='blog/covers/', blank=True, null=True)
    language    = models.CharField(max_length=4, choices=LANG_CHOICES, default='both')
    status      = models.CharField(max_length=10, choices=STATUS_CHOICES, default='draft')

    created_at  = models.DateTimeField(auto_now_add=True)
    updated_at  = models.DateTimeField(auto_now=True)
    published_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        ordering = ['-published_at', '-created_at']

    def __str__(self):
        return self.title

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title)
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('blog:post_detail', kwargs={'slug': self.slug})

    @property
    def display_title(self):
        """Return Afrikaans title if available, else English."""
        return self.title_af or self.title

    @property
    def display_excerpt(self):
        return self.excerpt_af or self.excerpt or self.body[:200]

    @property
    def comment_count(self):
        return self.comments.filter(approved=True).count()


class Comment(models.Model):
    post        = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='comments')
    author_name = models.CharField(max_length=100, verbose_name='Naam / Name')
    author_email = models.EmailField(verbose_name='E-pos / Email')
    body        = models.TextField(verbose_name='Kommentaar / Comment')
    approved    = models.BooleanField(default=False)
    created_at  = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created_at']

    def __str__(self):
        return f'{self.author_name} on "{self.post.title}"'
