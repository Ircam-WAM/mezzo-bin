#!/bin/bash

# dump postgres or mysql functions of the database
# export POSTGRES="$(dpkg --get-selections  | grep postgres 2>&1)"
# export MYSQL="$(dpkg --get-selections  | grep mysql 2>&1)"

if [ ! -z "$MYSQL_PASSWORD" ]; then
    export MYSQL_PWD=$MYSQL_PASSWORD
    mysqldump $MYSQL_DATABASE -hdb -u$MYSQL_USER | gzip > /srv/backup/mariadb.dump.gz
elif [ ! -z "$POSTGRES_PASSWORD" ]; then
    export PGPASSWORD=$POSTGRES_PASSWORD
    now=$(date +"%m_%d_%Y_%H_%M_%S")
    pg_dump -Fc -hdb -Upostgres -dpostgres > /srv/backup/postgres_$now.dump
    rm -f /srv/backup/postgres_latest.dump
    ln -s /srv/backup/postgres_$now.dump /srv/backup/postgres_latest.dump
fi

echo "Backup done!"
