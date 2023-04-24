#!/bin/bash

# /srv/bin/misc/wait-for-it/wait-for-it.sh -h db -p $DB_PORT;

# Stop execution if some command fails
set -e

DIR=/srv/backup/
FILE=`ls -t $DIR/* | head -1`

echo "Restoring $FILE"

# import database functions of type
if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    if [[ $FILE == *".gz" ]]; then
        gunzip < $FILE | mysql -h db $MYSQL_DATABASE -uroot -p$MYSQL_ROOT_PASSWORD
    else
        mysql -h db $MYSQL_DATABASE -uroot -p$MYSQL_ROOT_PASSWORD < $FILE
    fi
elif [ ! -z "$POSTGRES_PASSWORD" ]; then
    export PGPASSWORD=$POSTGRES_PASSWORD
    if [ ! -z "$POSTGRES_DB" ]; then
        export POSTGRES_NAME=$POSTGRES_DB
    fi
    if [ "$( psql -hdb -Upostgres -XtAc "SELECT 1 FROM pg_database WHERE datname='$POSTGRES_NAME'" )" = '1' ]
    then
        echo "Database already exists"
        echo "Killing clients..."
        psql -hdb -Upostgres -d$POSTGRES_NAME -c "SELECT pid, (SELECT pg_terminate_backend(pid)) as killed from pg_stat_activity WHERE state LIKE 'idle';"
        echo "Dropping db..."
        # dropdb -hdb -Upostgres $POSTGRES_NAME
    else
        echo "Database does not exist"
        echo "Creating new db..."
        createdb -hdb -Upostgres -T template0 $POSTGRES_NAME
    fi
    echo "Importing dump..."
    if [[ $FILE == *".gz" ]]; then
        gunzip < $FILE | psql -hdb -Upostgres -d$POSTGRES_NAME
    elif [[ $FILE == *".dump" ]]; then
        pg_restore -c -C -hdb -Upostgres -d$POSTGRES_NAME < $FILE
    fi
fi

echo "Restore done!"
