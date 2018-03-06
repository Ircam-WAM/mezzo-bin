#!/bin/bash

# import dump functions of the database (postgres or mysql)
# export POSTGRES="$(dpkg --get-selections  | grep postgres 2>&1)"
# export MYSQL="$(dpkg --get-selections  | grep mysql 2>&1)"

if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    export MYSQL_PWD=$MYSQL_ROOT_PASSWORD
    gunzip < /srv/backup/mariadb.dump.gz | mysql -h db $MYSQL_DATABASE -uroot
elif [ ! -z "$POSTGRES_PASSWORD" ]; then
    export PGPASSWORD=$POSTGRES_PASSWORD
    pg_restore -c -hdb -Upostgres -dpostgres  /srv/backup/postgres.dump
fi

echo "Restore done!"
