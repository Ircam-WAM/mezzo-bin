#!/bin/sh

docker-compose run app python /srv/app/manage.py collectstatic --no-input

sudo chown -R www-data: var/media var/static
