#!/bin/bash

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      echo "Not found ${SQL_HOST}:${SQL_PORT}"
      sleep 0.5
    done

    echo "PostgreSQL started"
fi

echo "${0}: running migrations."
python manage.py makemigrations --merge
python manage.py migrate --noinput

exec "$@"