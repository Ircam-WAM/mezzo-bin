#!/bin/sh

# We need to chown folders as they are docker's volumes
sudo chown -R $USER var/media
sudo chown -R $USER var/backup

# Update main project
git pull

# Update submodules
./bin/update_submodules.sh

# Restore database
if [ "$1" = "--restore-db" ];
    then
    docker-compose run db /srv/bin/db/restore.sh
fi

