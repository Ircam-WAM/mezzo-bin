#!/bin/bash

/srv/bin/misc/wait-for-it/wait-for-it.sh -h db -p $DB_PORT;

# Stop execution if some command fails
set -e

echo "Restoring..."

# import database functions of type
if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    gunzip < /srv/backup/mysql.dump.gz | mysql -h db $MYSQL_DATABASE -uroot -p$MYSQL_ROOT_PASSWORD
elif [ ! -z "$POSTGRES_PASSWORD" ]; then
    export PGPASSWORD=$POSTGRES_PASSWORD
    echo "Killing clients..."
    psql -h$POSTGRES_HOST -U$POSTGRES_USER -d$POSTGRES_DB -c "SELECT pid, (SELECT pg_terminate_backend(pid)) as killed from pg_stat_activity WHERE state LIKE 'idle';"
    echo "Dropping db..."
    dropdb -h$POSTGRES_HOST -U$POSTGRES_USER $POSTGRES_DB
    echo "Creating new db..."
    createdb -h$POSTGRES_HOST -U$POSTGRES_USER -T template0 $POSTGRES_DB
    echo "Importing dump..."
    pg_restore -C -c -h$POSTGRES_HOST -U$POSTGRES_USER -d$POSTGRES_DB /srv/backup/postgres.dump
fi

echo "Restore done!"
