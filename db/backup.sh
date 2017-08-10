#!/bin/bash

# dump postgres or mysql functions of the database
export POSTGRES="$(dpkg --get-selections  | grep postgres 2>&1)"
export MYSQL="$(dpkg --get-selections  | grep mysql 2>&1)"

if [ ! -z "$MYSQL" ];
    then
    export MYSQL_PWD=$MYSQL_PASSWORD
    mysqldump $MYSQL_DATABASE -hdb -u$MYSQL_USER > /srv/backup/mariadb.dump
elif [ ! -z "$POSTGRES" ];
    then
    export PGUSER="postgres"
    export PGPASSWORD=$POSTGRES_PASSWORD
    export PGDATABASE="postgres"
    pg_dump -Fc -hdb > /srv/backup/postgres.dump
fi

echo "Backup done!"
