#!/bin/sh

docker-compose exec -T db bash -c 'gunzip < /srv/backup/mysql.sql.gz | mysql -uroot -p"$MYSQL_ROOT_PASSWORD"'
