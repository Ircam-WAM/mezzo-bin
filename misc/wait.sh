#!/bin/bash

set -e

apt update
apt install -y netcat

HOST=db
PORT=5432

echo -n "waiting for TCP connection to $HOST:$PORT..."

while ! nc -w 1 $HOST $PORT 2>/dev/null
do
  echo -n .
  sleep 1
done

echo 'ok'
