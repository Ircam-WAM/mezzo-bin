#!/bin/bash

# dump postgres or mysql functions of the database
# export POSTGRES="$(dpkg --get-selections  | grep postgres 2>&1)"
# export MYSQL="$(dpkg --get-selections  | grep mysql 2>&1)"

# Stop execution if some command fails
set -e

if [ ! -z "$MYSQL_PASSWORD" ]; then
    export MYSQL_PWD=$MYSQL_PASSWORD
    mysqldump $MYSQL_DATABASE -hdb -u$MYSQL_USER | gzip > /srv/backup/mysql.dump.gz
elif [ ! -z "$POSTGRES_PASSWORD" ]; then
    export PGPASSWORD=$POSTGRES_PASSWORD
    pg_dump -Fc -h$POSTGRES_HOST -U$POSTGRES_USER -d$POSTGRES_DB > /srv/backup/postgres.dump
fi

echo "Backup done!"
