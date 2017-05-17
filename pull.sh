#!/bin/sh

sudo chown -R $USER var/media
sudo chown -R $USER var/backup
git pull
git submodule foreach --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
git submodule foreach --recursive 'git pull origin $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
if [ "$1" = "--restore-db" ];
    then
    docker-compose run db /srv/bin/db/restore.sh
fi
docker-compose run app bash -c "cd /srv && bower --allow-root install && gulp build"
