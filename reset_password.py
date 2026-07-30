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

u = User.objects.get(username='admin')
u.username   = 'Cadanter'
u.first_name = 'Danie'
u.last_name  = 'van Eeden'
u.email      = 'your@email.com'
u.set_password('DanVan&52679!')
u.save()
print(f'User updated: {u.username}')