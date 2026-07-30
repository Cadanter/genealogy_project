import os
import sys
import pymysql
pymysql.install_as_MySQLdb()

PROJECT_ROOT = '/home/mdpkmtdv/danie'
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

os.environ['DJANGO_SETTINGS_MODULE'] = 'config.settings'

env_path = os.path.join(PROJECT_ROOT, '.env')
if os.path.exists(env_path):
    with open(env_path, encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#') and '=' in line:
                key, _, value = line.partition('=')
                os.environ.setdefault(key.strip(), value.strip().strip("'\""))

import django
django.setup()

from django.contrib.auth.models import User

users = User.objects.all()
if users.exists():
    for u in users:
        print(f'User: {u.username} | Superuser: {u.is_superuser} | Active: {u.is_active}')
else:
    print('No users found in database')