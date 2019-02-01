#!/bin/sh

docker-compose stop
sudo rm -rf var/lib/postgresql
./bin/dev/restore_db.sh
./bin/dev/migrate.sh
./bin/dev/up.sh