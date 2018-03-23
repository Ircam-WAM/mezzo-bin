#!/bin/sh

docker-compose exec app python /srv/app/manage.py build-front
