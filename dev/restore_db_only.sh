#!/bin/sh

docker compose exec db /srv/bin/dev/local/restore_db.sh
