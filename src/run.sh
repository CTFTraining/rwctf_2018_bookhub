#!/bin/sh

redis-server &

exec gunicorn -w 4 -b :8000 -u nobody -g nogroup --access-logfile - app:app