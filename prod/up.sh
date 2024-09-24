#!/bin/sh

options=""

if [ "$1" = "-d" ]; then
    options=$options" -d";
fi

docker compose -f docker compose.yml -f env/prod.yml up $options
