#!/bin/bash

docker-compose exec db bash -c 'mysqldump  --add-drop-database --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD" | gzip > /srv/backup/mysql.sql.gz' 
