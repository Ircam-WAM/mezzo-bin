#!/bin/bash

set -e

apt update
apt install -y netcat

HOST=$(env | grep _TCP_ADDR | cut -d = -f 2)
PORT=$(env | grep _TCP_PORT | cut -d = -f 2)  

echo -n "waiting for TCP connection to $HOST:$PORT..."

while ! nc -w 1 $HOST $PORT 2>/dev/null
do
  echo -n .
  sleep 1
done

echo 'ok'
