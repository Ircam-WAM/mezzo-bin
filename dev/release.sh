#!/bin/sh

git checkout master
bin/dev/update.sh
bin/dev/merge.sh
bin/dev/push.sh
