#!/bin/sh

# Update main project
git pull

# Update submodules
./bin/update_submodules.sh

# Apply migrations
docker-compose run app python /srv/app/manage.py migrate

# Build front-end
./bin/build_front.sh

# Build documentation
docker-compose run app bash /srv/doc/build.sh

# Reload Wsgi
if [ "$1" = "--reload-wsgi" ];
    then
    touch app/wsgi.py
fi

# Install local cron to
if [ "$1" = "--cron" ];
    then
    sudo cp /srv/ircam-www/etc/cron.d/app /etc/cron.d/ircam-www
fi
