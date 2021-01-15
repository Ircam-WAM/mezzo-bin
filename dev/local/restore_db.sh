#!/bin/bash

/srv/bin/misc/wait-for-it/wait-for-it.sh -h db -p $DB_PORT;

# Stop execution if some command fails
set -e

echo "Restoring..."

# Migrate backup to date-based format
if [ -f /srv/backup/postgres.dump ]; then
    echo 'A backup without date was found. Moving it to postgres_old.dump'
    mv /srv/backup/postgres.dump /srv/backup/postgres_old.dump
    if [ ! -f /srv/backup/postgres_latest.dump ]; then
      ln -s /srv/backup/postgres_old.dump /srv/backup/postgres_latest.dump
    fi
fi

# import database functions of type
if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    gunzip < /srv/backup/mysql.dump.gz | mysql -h db $MYSQL_DATABASE -uroot -p$MYSQL_ROOT_PASSWORD
elif [ ! -z "$POSTGRES_PASSWORD" ]; then
    export PGPASSWORD=$POSTGRES_PASSWORD
    echo "Killing clients..."
    psql -hdb -Upostgres -dpostgres -c "SELECT pid, (SELECT pg_terminate_backend(pid)) as killed from pg_stat_activity WHERE state LIKE 'idle';"
    echo "Dropping db..."
    dropdb -hdb -Upostgres postgres
    echo "Creating new db..."
    createdb -hdb -Upostgres -T template0 postgres
    echo "Importing dump..."
    pg_restore -C -c -hdb -Upostgres -dpostgres /srv/backup/${1:-postgres_latest.dump}
fi

echo "Restore done!"
