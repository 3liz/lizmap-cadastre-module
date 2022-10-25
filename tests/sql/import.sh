#!/bin/bash

SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )"

echo "DROP SCHEMA"
PGPASSWORD=lizmap1234! psql -h localhost -p 9087 -U lizmap -c "DROP SCHEMA IF EXISTS cadastre_caen;"
PGPASSWORD=lizmap1234! psql -h localhost -p 9087 -U lizmap -c "DROP SCHEMA IF EXISTS cadastre_mtp;"

echo "* Run file $SCRIPTDIR/structure/schema-caen.sql"
PGPASSWORD=lizmap1234! psql -h localhost -p 9087 -U lizmap -f $SCRIPTDIR/structure/schema-caen.sql

echo "* Run file $SCRIPTDIR/structure/schema-mtp.sql"
PGPASSWORD=lizmap1234! psql -h localhost -p 9087 -U lizmap -f $SCRIPTDIR/structure/schema-mtp.sql

for file in $SCRIPTDIR/majic/*.sql
do
  echo $file
  PGPASSWORD=lizmap1234! psql -v ON_ERROR_STOP=1 -h localhost -p 9087 -U lizmap -f $file
done
