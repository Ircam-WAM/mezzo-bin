# docker-compose run app python manage.py compilemessages
cd /srv

find $(pwd)  -type d -name 'locale' -print | while read f; do
    cd "$f" && cd ..
    echo $(pwd)
    django-admin makemessages --all
    django-admin compilemessages
done
