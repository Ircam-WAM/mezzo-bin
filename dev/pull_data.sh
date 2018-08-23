#!/bin/bash

cd "$(dirname "$0")"/../../

bin/misc/fix_var_perms.sh

cd "$(dirname "$0")"/../../var/

git pull

# Restore database
if [ "$1" = "--restore-db" ]; then
    cd ..
    bin/dev/restore_db_only.sh
fi
