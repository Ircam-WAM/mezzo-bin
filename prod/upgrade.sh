#!/bin/bash

cd "$(dirname "$0")"/../../

# Update main project and submodules
./bin/prod/update.sh

# Apply migrations
if [ "$1" = "--migrate" ]; then
    docker-compose run app python /srv/app/manage.py migrate
fi

# Build front-end
if [ "$1" = "--front" ]; then
    docker-compose run app python /srv/app/manage.py build-front
fi

# Build documentation
if [ "$1" = "--doc" ]; then
    docker-compose run app bash /srv/doc/build.sh
fi

# Collect static files
if [ "$1" = "--collect" ]; then
    docker-compose run app python manage.py collectstatic --noinput
fi

# Reload Wsgi
if [ "$1" = "--reload" ]; then
    touch app/wsgi.py
fi

# Install local cron to
if [ "$1" = "--cron" ]; then
    sudo cp ./etc/cron.d/* /etc/cron.d/
fi
