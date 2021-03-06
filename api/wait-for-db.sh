#!/bin/bash

set -e

CMD="$@"

while ! PGPASSWORD=$POSTGRES_PASSWORD pg_isready -h "db" -U "$POSTGRES_USER" -d "$POSTGRES_DATABASE_API" > /dev/null 2> /dev/null; do
  echo "Waiting for database to be ready ..."
  sleep 5
done

>&2 echo "Database is ready!"

export DATABASE_URL=postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@db:5432/$POSTGRES_DATABASE_API
export DATABASE_DIALECT=postgres

exec $CMD
