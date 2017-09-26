#!/bin/bash

echo 'ok'
ls /srv/lib/
for module in `ls /srv/lib/`; do
	cd /srv/lib/$module
	echo "/srv/lib/$module"
	python setup.py develop
done
