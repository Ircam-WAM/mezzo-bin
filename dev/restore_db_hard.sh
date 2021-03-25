#!/bin/sh

docker-compose stop
sudo rm -rf var/lib/postgresql/*
# sudo rm -rf var/lib/mysql/*
./bin/dev/restore_db.sh
./bin/dev/migrate.sh
./bin/dev/up.sh