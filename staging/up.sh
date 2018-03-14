#!/bin/sh

docker-compose -f docker-compose.yml -f env/staging.yml up
