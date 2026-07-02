from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):
    initial = True
    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]
    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('name',    models.CharField(max_length=80)),
                ('name_af', models.CharField(blank=True, max_length=80)),
                ('slug',    models.SlugField(unique=True)),
                ('description', models.TextField(blank=True)),
            ],
            options={'ordering': ['name'], 'verbose_name_plural': 'Categories'},
        ),
        migrations.CreateModel(
            name='Tag',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=50)),
                ('slug', models.SlugField(unique=True)),
            ],
            options={'ordering': ['name']},
        ),
        migrations.CreateModel(
            name='Post',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('title',       models.CharField(max_length=200)),
                ('title_af',    models.CharField(blank=True, max_length=200)),
                ('slug',        models.SlugField(max_length=220, unique=True)),
                ('body',        models.TextField()),
                ('body_af',     models.TextField(blank=True)),
                ('excerpt',     models.TextField(blank=True)),
                ('excerpt_af',  models.TextField(blank=True)),
                ('cover_image', models.ImageField(blank=True, null=True, upload_to='blog/covers/')),
                ('language',    models.CharField(choices=[('af','Afrikaans'),('en','English'),('both','Beide / Both')], default='both', max_length=4)),
                ('status',      models.CharField(choices=[('draft','Konsep / Draft'),('published','Gepubliseer / Published')], default='draft', max_length=10)),
                ('created_at',  models.DateTimeField(auto_now_add=True)),
                ('updated_at',  models.DateTimeField(auto_now=True)),
                ('published_at', models.DateTimeField(blank=True, null=True)),
                ('author',   models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='posts', to=settings.AUTH_USER_MODEL)),
                ('category', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='posts', to='blog.category')),
                ('tags',     models.ManyToManyField(blank=True, related_name='posts', to='blog.tag')),
            ],
            options={'ordering': ['-published_at', '-created_at']},
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False)),
                ('author_name',  models.CharField(max_length=100)),
                ('author_email', models.EmailField()),
                ('body',         models.TextField()),
                ('approved',     models.BooleanField(default=False)),
                ('created_at',   models.DateTimeField(auto_now_add=True)),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comments', to='blog.post')),
            ],
            options={'ordering': ['created_at']},
        ),
    ]
