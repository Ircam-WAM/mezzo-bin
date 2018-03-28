#!/bin/bash

cd "$(dirname "$0")"/../../

echo "----------------------------"
echo `date +\%Y\%m\%d-\%H-\%M-\%S`

./bin/prod/backup_db.sh

cd "$(dirname "$0")"/../../var

git add .
git commit -a -m "update DB and media"
git pull
git push
