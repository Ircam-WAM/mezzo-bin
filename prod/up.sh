#!/bin/sh

docker-compose -f docker-compose.yml -f env/prod.yml up `if [ "$1" = "-bg" ]; then echo "-d"; fi`