#!/bin/bash

cd "$(dirname "$0")"/../../

function usage() {
    echo "upgrade the Mezzo production instance with various options"
    echo ""
    echo "./upgrade.sh"
    echo "  -h --help"
    echo "  -u --update : update main project and submodules"
    echo "  -uhr --update-hard-reset : update and hard reset main project and submodules"
    echo "  -m --migrate : apply migrations"
    echo "  -f --front : build frontend"
    echo "  -d --doc : build documentation"
    echo "  -c --collect : collect static files"
    echo "  -r --reload : reload wsgi"
    echo "  -n --cron : install local cron to host"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -u | --update)
            ./bin/prod/update.sh
            ;;
        -uhr | --update-hard-reset)
            ./bin/prod/update.sh -hr
            ;;
        -m | --migrate)
            docker-compose run app python /srv/app/manage.py migrate --noinput
            ;;
        -i | --install)
            docker-compose exec app poetry install --no-root
            ;;
        -f | --front)
            docker-compose run app python /srv/app/manage.py build-front
            ;;
        -fi | --front-install)
            docker-compose run app python /srv/app/manage.py build-front --force-npm --force-bower
            ;;
        -d | --doc)
            docker-compose run app bash /srv/doc/build.sh
            ;;
        -c | --collect)
            docker-compose run app python manage.py collectstatic --noinput
            ;;
        -r | --reload)
            touch app/wsgi.py
            ;;
        -n | --cron)
            sudo cp ./etc/cron.d/* /etc/cron.d/
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done
