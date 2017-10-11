#!/bin/bash

ls /srv/lib/
for module in `ls /srv/lib/`; do
	cd /srv/lib/$module
	if [ -f 'requirements.txt' ]; then
		pip install -r requirements.txt
	else
		python setup.py develop
	fi
done
