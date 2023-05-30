#!/bin/bash
python /srv/app/manage.py rename_app organization-core organization_core
python /srv/app/manage.py rename_app organization-agenda organization_agenda
python /srv/app/manage.py rename_app organization-formats organization_formats
python /srv/app/manage.py rename_app organization-job organization_job
python /srv/app/manage.py rename_app organization-magazine organization_magazine
python /srv/app/manage.py rename_app organization-media organization_media
python /srv/app/manage.py rename_app organization-network organization_network
python /srv/app/manage.py rename_app organization-pages organization_pages
python /srv/app/manage.py rename_app organization-projects organization_projects
python /srv/app/manage.py rename_app organization-shop organization_shop

python /srv/app/manage.py migrate rest_framework_api_key zero
python /srv/app/manage.py migrate rest_framework_api_key

python /srv/app/manage.py migrate
