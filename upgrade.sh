#!/bin/sh

# Update main project
git pull
# Synchronizes submodules' remote URL configuration setting to the value specified in .gitmodules
git submodule sync
# Checkout all submodules on right branches specified in .gitmodules, by default the branch is master
git submodule foreach --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
# Pull all submodules on right branches specified in .gitmodules, by default the branch is master
git submodule foreach --recursive 'git pull origin $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
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
