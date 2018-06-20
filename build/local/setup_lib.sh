#!/bin/bash

for module in `ls /srv/lib/`; do
	cd /srv/lib/$module
	if [ -f 'requirements.txt' ]; then
		pip install -r requirements.txt
	else
		pip install -e .
	fi
done
