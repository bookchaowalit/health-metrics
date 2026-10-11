-- Roles for the health database. Locally a superuser runs this; on Neon
-- `health-db provision` creates the same roles through the migrator.
--
-- health_migrator  owns the schema and runs migrations only.
-- health_api       the API at runtime: no superuser, no BYPASSRLS, owns nothing.
-- health_publisher sweeps and marks the outbox across workspaces; nothing else.

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'health_migrator') THEN
        CREATE ROLE health_migrator LOGIN NOSUPERUSER NOCREATEROLE NOBYPASSRLS;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'health_api') THEN
        CREATE ROLE health_api LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOBYPASSRLS NOINHERIT;
    END IF;
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'health_publisher') THEN
        CREATE ROLE health_publisher LOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOBYPASSRLS NOINHERIT;
    END IF;
END
$$;
