#!/bin/sh

docker-compose -f docker-compose.yml -f env/prod.yml up
