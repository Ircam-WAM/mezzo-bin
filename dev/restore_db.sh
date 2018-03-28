#!/bin/sh

docker-compose up -d db
docker-compose run db bash -c "/srv/bin/misc/wait.sh; /srv/bin/dev/local/restore_db.sh"
docker-compose stop db
