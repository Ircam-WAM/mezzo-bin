#!/bin/bash

for module in `ls /srv/lib/`; do
	cd /srv/lib/$module
	if [ -f 'requirements.txt' ]; then
		pip install -r requirements.txt
	elif [ -f 'setup.py' ]; then
		pip install -e .
	fi
done
