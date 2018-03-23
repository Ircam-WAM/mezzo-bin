#!/bin/sh
options = ""
if [ "$1" = "-bg" ]; then
    options = $options "-d";
fi
docker-compose -f docker-compose.yml -f env/prod.yml up $options