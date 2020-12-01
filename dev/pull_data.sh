#!/bin/bash

cd "$(dirname "$0")"/../../

bin/misc/fix_var_perms.sh

cd "$(dirname "$0")"/../../var/

git reset --hard origin/master
git pull origin master
sudo chown -R www-data: media static

# Restore database
if [ "$1" = "--restore-db" ]; then
    cd ..
    bin/dev/restore_db_only.sh
fi
