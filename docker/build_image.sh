#!/bin/sh

# Always remove intermediate containers and build app in dev mode
docker-compose -f docker-compose.yml -f env/build.yml build --force-rm --no-cache
# Delete all stopped containers (including data-only containers)
docker rm $(docker ps -a -q)
# Delete all 'untagged/dangling' (<none>) images
docker rmi $(docker images -q -f dangling=true)
# restart app container
docker-compose restart app
