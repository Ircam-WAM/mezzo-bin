#!/bin/bash

cd "$(dirname "$0")"/../../

# We need to chown folders as they are docker's volumes
sudo chown -R $USER var/media
sudo chown -R $USER var/backup

# Update main project
git pull

# Update submodules
./bin/dev/update_submodules.sh

# Restore database
if [ "$1" = "--restore-db" ]; then
    docker-compose run db /srv/bin/dev/restore_db.sh
fi

# We need to chown folders as they are docker's volumes
# (do not work on OSX, hence the test)
if ! uname -a | grep Darwin > /dev/null; then
  sudo chown -R www-data var/media
  sudo chown -R root var/backup
fi
