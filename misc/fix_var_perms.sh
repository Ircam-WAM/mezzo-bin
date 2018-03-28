#!/bin/bash

cd "$(dirname "$0")"/../../

# We need to chown folders so that they can be used by the $USER (with an exception on Darwin)
if ! uname -a | grep Darwin > /dev/null; then
    INFO=( $(stat -L -c "%a %G %U" var) )
    OWNER=${INFO[2]}
    if [ "$OWNER" != "$USER" ]; then
        sudo chown $USER var
        sudo chown -R $USER var/media
        sudo chown -R $USER var/backup
    fi
fi
