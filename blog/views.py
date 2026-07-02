from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db.models import Q
from django.utils import timezone

from .models import Post, Category, Tag, Comment
from .forms import CommentForm, PostForm


def post_list(request):
    posts = Post.objects.filter(status='published').select_related('author', 'category')
    query = request.GET.get('q', '')
    category_slug = request.GET.get('kategorie', '')
    tag_slug = request.GET.get('etiket', '')

    if query:
        posts = posts.filter(
            Q(title__icontains=query) | Q(title_af__icontains=query) |
            Q(body__icontains=query)  | Q(body_af__icontains=query) |
            Q(excerpt__icontains=query)
        )
    if category_slug:
        posts = posts.filter(category__slug=category_slug)
    if tag_slug:
        posts = posts.filter(tags__slug=tag_slug)

    categories = Category.objects.all()
    tags = Tag.objects.all()
    return render(request, 'blog/post_list.html', {
        'posts': posts, 'categories': categories, 'tags': tags,
        'query': query, 'category_slug': category_slug, 'tag_slug': tag_slug,
    })


def post_detail(request, slug):
    post = get_object_or_404(Post, slug=slug, status='published')
    comments = post.comments.filter(approved=True)
    form = CommentForm()

    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.post = post
            comment.save()
            messages.success(request,
                'Dankie! U kommentaar wag op goedkeuring. / Thank you! Your comment awaits approval.')
            return redirect('blog:post_detail', slug=slug)

    related = Post.objects.filter(
        status='published', category=post.category
    ).exclude(pk=post.pk)[:3] if post.category else []

    return render(request, 'blog/post_detail.html', {
        'post': post, 'comments': comments,
        'form': form, 'related': related,
    })


def category_view(request, slug):
    category = get_object_or_404(Category, slug=slug)
    posts = Post.objects.filter(status='published', category=category)
    return render(request, 'blog/post_list.html', {
        'posts': posts, 'active_category': category,
        'categories': Category.objects.all(),
        'tags': Tag.objects.all(),
    })


def tag_view(request, slug):
    tag = get_object_or_404(Tag, slug=slug)
    posts = Post.objects.filter(status='published', tags=tag)
    return render(request, 'blog/post_list.html', {
        'posts': posts, 'active_tag': tag,
        'categories': Category.objects.all(),
        'tags': Tag.objects.all(),
    })


# ── Admin-only post management ────────────────────────────────────────────

@login_required
def post_create(request):
    if not request.user.is_staff:
        messages.error(request, 'Slegs die eienaar kan plasings skep. / Only the owner can create posts.')
        return redirect('blog:post_list')
    if request.method == 'POST':
        form = PostForm(request.POST, request.FILES)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            if post.status == 'published' and not post.published_at:
                post.published_at = timezone.now()
            post.save()
            form.save_m2m()
            messages.success(request, f'Plasing "{post.title}" geskep.')
            return redirect('blog:post_detail', slug=post.slug)
    else:
        form = PostForm()
    return render(request, 'blog/post_form.html', {'form': form, 'title': 'Nuwe plasing / New post'})


@login_required
def post_edit(request, slug):
    if not request.user.is_staff:
        return redirect('blog:post_list')
    post = get_object_or_404(Post, slug=slug)
    if request.method == 'POST':
        form = PostForm(request.POST, request.FILES, instance=post)
        if form.is_valid():
            updated = form.save(commit=False)
            if updated.status == 'published' and not updated.published_at:
                updated.published_at = timezone.now()
            updated.save()
            form.save_m2m()
            messages.success(request, 'Plasing opgedateer.')
            return redirect('blog:post_detail', slug=post.slug)
    else:
        form = PostForm(instance=post)
    return render(request, 'blog/post_form.html', {'form': form, 'title': 'Wysig plasing / Edit post', 'post': post})


@login_required
def post_delete(request, slug):
    if not request.user.is_staff:
        return redirect('blog:post_list')
    post = get_object_or_404(Post, slug=slug)
    if request.method == 'POST':
        post.delete()
        messages.success(request, 'Plasing verwyder.')
        return redirect('blog:post_list')
    return render(request, 'blog/post_confirm_delete.html', {'post': post})


@login_required
def drafts(request):
    if not request.user.is_staff:
        return redirect('blog:post_list')
    posts = Post.objects.filter(status='draft').order_by('-created_at')
    return render(request, 'blog/drafts.html', {'posts': posts})


@login_required
def approve_comments(request):
    if not request.user.is_staff:
        return redirect('blog:post_list')
    pending = Comment.objects.filter(approved=False).select_related('post')
    if request.method == 'POST':
        comment_id = request.POST.get('comment_id')
        action = request.POST.get('action')
        comment = get_object_or_404(Comment, pk=comment_id)
        if action == 'approve':
            comment.approved = True
            comment.save()
            messages.success(request, 'Kommentaar goedgekeur.')
        elif action == 'delete':
            comment.delete()
            messages.success(request, 'Kommentaar verwyder.')
        return redirect('blog:approve_comments')
    return render(request, 'blog/approve_comments.html', {'pending': pending})
