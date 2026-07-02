"""
Usage: python manage.py make_admin username
Promotes a user to admin role in UserProfile.
"""
from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth.models import User
from genealogy.models import UserProfile


class Command(BaseCommand):
    help = 'Promote a user to admin role'

    def add_arguments(self, parser):
        parser.add_argument('username', type=str)

    def handle(self, *args, **options):
        try:
            user = User.objects.get(username=options['username'])
        except User.DoesNotExist:
            raise CommandError(f"User '{options['username']}' not found.")
        profile, _ = UserProfile.objects.get_or_create(user=user, defaults={'role': 'admin'})
        profile.role = 'admin'
        profile.save()
        self.stdout.write(self.style.SUCCESS(f"✓ {user.username} is now an admin."))
