#!/bin/sh

# We need to chown folders as they are docker's volumes
sudo chown -R $USER var/media
sudo chown -R $USER var/backup

# Update main project
git pull
# Synchronizes submodules' remote URL configuration setting to the value specified in .gitmodules
git submodule sync
# Checkout all submodules on right branches specified in .gitmodules, by default the branch is master
git submodule foreach --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
# Pull all submodules on right branches specified in .gitmodules, by default the branch is master
git submodule foreach --recursive 'git pull origin $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
# Restore database
if [ "$1" = "--restore-db" ];
    then
    docker-compose run db /srv/bin/db/restore.sh
fi
# Build front-end
docker-compose run app bash -c "cd /srv && bower --allow-root install && gulp build"
