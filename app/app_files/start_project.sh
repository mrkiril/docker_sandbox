#!/usr/bin/env bash
set -e

service nginx start
echo "Start NGINX"

#python3 /app/market/manage.py runserver docker.django:5000
#echo "python3 /app/market/manage.py runserver 127.10.10.1:5000"

# Те що прописане в докерфайлі в розділі CMD
# прокинеться сюди командою яка замінить собою шелл
cmd="$@"
echo "CMD >>", $cmd
exec $cmd
