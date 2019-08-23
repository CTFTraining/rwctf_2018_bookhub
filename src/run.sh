#!/bin/sh

echo $FLAG > /flag_378d0265d46a10d2f6d99ea199fb39d4
export FLAG=not_flag
FLAG=not_flag

redis-server &

exec gunicorn -w 4 -b :8000 -u nobody -g nogroup --access-logfile - app:app
