#!/bin/bash

cd "$(dirname "$0")"/../../

bin/misc/fix_var_perms.sh

cd "$(dirname "$0")"/../../var/

git pull

# Restore database
if [ "$1" = "--restore-db" ]; then
    docker-compose run db /srv/bin/dev/restore_db.sh
fi
