#!/bin/bash

if [ -z "$1" ]; then
    echo -e "[WARNING] Please provide the name of package you want to install.\nThen execute the command : ./bin/dev/poetry_add.sh [name_of_package]"
else
    docker compose exec app poetry add $1
fi
