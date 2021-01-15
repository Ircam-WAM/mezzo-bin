#!/bin/bash

/srv/bin/misc/wait-for-it/wait-for-it.sh -h db -p $DB_PORT;

set -e

echo "Restoring..."

# import database functions of type
if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    gunzip < /srv/backup/mysql.dump.gz | mysql -h db $MYSQL_DATABASE -uroot -p$MYSQL_ROOT_PASSWORD
elif [ ! -z "$POSTGRES_PASSWORD" ]; then
    export PGPASSWORD=$POSTGRES_PASSWORD
    pg_restore -c -C -hdb -Upostgres -dpostgres  /srv/backup/postgres.dump
fi

echo "Restore done!"
