#!/bin/bash

cd "$(dirname "$0")"/../../var

# We need to chown folders as they are docker's volumes
sudo chown -R $USER media
sudo chown -R $USER backup

git pull

# Restore database
if [ "$1" = "--restore-db" ]; then
    docker-compose run db /srv/bin/dev/restore_db.sh
fi

# We need to chown folders as they are docker's volumes
# (do not work on OSX, hence the test)
if ! uname -a | grep Darwin > /dev/null; then
  sudo chown -R www-data media
  sudo chown -R root backup
fi
