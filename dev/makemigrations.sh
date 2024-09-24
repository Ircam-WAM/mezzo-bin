#!/bin/sh

docker compose run app python /srv/app/manage.py makemigrations -v 3 $1
