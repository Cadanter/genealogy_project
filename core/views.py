from django.shortcuts import render


def landing(request):
    return render(request, 'core/landing.html')


def user_manual(request):
    from genealogy.models import UserProfile
    profile = None
    if hasattr(request.user, 'profile'):
        try:
            profile = request.user.profile
        except Exception:
            pass
    return render(request, 'genealogy/manual.html', {'profile': profile})
