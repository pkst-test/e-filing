#!/bin/bash
#to create Alfresco And Bonita users and databases
sed -i "s/^.*max_prepared_transactions\s*=\s*\(.*\)$/max_prepared_transactions = 100/" "$PGDATA"/postgresql.conf
sed -i "s/^.*max_connections\s*=\s*\(.*\)$/max_connections = 275/" "$PGDATA"/postgresql.conf

sed -i "s/^host\sall\sall\sall\smd5$/host all all all password/" "$PGDATA"/pg_hba.conf
echo "host all all all md5" >>"$PGDATA"/pg_hba.conf

set -e
echo "POSTGRES_USER $POSTGRES_USER"
echo "POSTGRES_DB $POSTGRES_DB"
echo "ALFRESCO_DB_USER $ALFRESCO_DB_USER"
echo "ALFRESCO_DB_USER_PASSWORD $ALFRESCO_DB_USER_PASSWORD"
echo "ALFRESCO_DB $ALFRESCO_DB"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE "$ALFRESCO_DB_USER" WITH LOGIN PASSWORD '$ALFRESCO_DB_USER_PASSWORD';
    CREATE DATABASE "$ALFRESCO_DB";
    GRANT ALL PRIVILEGES ON DATABASE "$ALFRESCO_DB" TO "$ALFRESCO_DB_USER";
EOSQL

echo "DONE CREATING ALFRESCO DB AND USER"

