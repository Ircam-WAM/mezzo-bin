#!/bin/sh

docker-compose exec app python /srv/app/manage.py makemigrations -v 3 $1
