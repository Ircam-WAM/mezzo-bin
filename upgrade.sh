#!/bin/sh

git pull
git submodule foreach --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
git submodule foreach --recursive 'git pull origin $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
docker-compose run app python /srv/app/manage.py migrate
# docker-compose run app python /srv/app/manage.py update_translation_fields
docker-compose run app bash -c "cd /srv && bower --allow-root install && gulp build"
docker-compose run app python /srv/app/manage.py collectstatic --noinput
docker-compose run app bash /srv/doc/build.sh
if [ "$1" = "--reload-wsgi" ];
    then
    touch app/wsgi.py
fi
