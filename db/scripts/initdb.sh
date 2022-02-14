#!/bin/bash
set -e
psql --set=ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  DO 'BEGIN
    CREATE ROLE $PGUSER_GUITAR_SHOP_OWNER WITH LOGIN PASSWORD ''$PGPASSWORD_GUITAR_SHOP_OWNER'';
    EXCEPTION WHEN duplicate_object THEN RAISE NOTICE ''%, skipping'', SQLERRM USING ERRCODE = SQLSTATE;
  END';
  DO 'BEGIN
    CREATE ROLE ${PGUSER_GUITAR_SHOP} WITH LOGIN PASSWORD ''$PGPASSWORD_GUITAR_SHOP'';
    EXCEPTION WHEN duplicate_object THEN RAISE NOTICE ''%, skipping'', SQLERRM USING ERRCODE = SQLSTATE;
  END';
  CREATE EXTENSION IF NOT EXISTS dblink;
  DO 'BEGIN
    IF EXISTS (SELECT FROM pg_database WHERE datname = ''$PGDATABASE'') THEN
      ALTER DATABASE $PGDATABASE OWNER TO $PGUSER_GUITAR_SHOP_OWNER;
      RAISE NOTICE ''Database already exists, skipping'';
    ELSE
      PERFORM dblink_exec(''dbname='' || current_database(), ''CREATE DATABASE $PGDATABASE WITH OWNER $PGUSER_GUITAR_SHOP_OWNER;'');
    END IF;
  END';
  \connect $PGDATABASE;
  CREATE EXTENSION IF NOT EXISTS pgcrypto;
  CREATE EXTENSION IF NOT EXISTS postgis;
  ALTER DATABASE $PGDATABASE SET search_path TO $PGSCHEMA,public;
  DO 'BEGIN
    CREATE PUBLICATION dbz_publication FOR ALL TABLES;
    EXCEPTION WHEN duplicate_object THEN RAISE NOTICE ''%, skipping'', SQLERRM USING ERRCODE = SQLSTATE;
  END';
EOSQL
