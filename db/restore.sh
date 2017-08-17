#!/bin/bash

# import dump functions of the database (postgres or mysql)
export POSTGRES="$(dpkg --get-selections  | grep postgres 2>&1)"
export MYSQL="$(dpkg --get-selections  | grep mysql 2>&1)"

if [ ! -z "$MYSQL" ];
    then
    export MYSQL_PWD=$MYSQL_PASSWORD
    mysql -h db $MYSQL_DATABASE -u$MYSQL_USER < /srv/backup/mariadb.dump
elif [ ! -z "$POSTGRES" ];
    then
    export PGUSER="postgres"
    export PGPASSWORD=$POSTGRES_PASSWORD
    export PGDATABASE="postgres"
    pg_restore -c -Fc -hdb /srv/backup/postgres.dump
fi

echo "Restore done!"
