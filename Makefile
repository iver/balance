ENV ?= dev
PG_HOST ?= localhost
PG_PORT ?= 5432
PG_USER ?= balance_$(ENV)
PG_PASS ?= balance
PG_DATABASE ?= balance_$(ENV)
PG_ROOT ?= iver
PG_ROOT_PASS ?= iver

shell:
	@PGPASSWORD=$(PG_PASS) psql -U$(PG_USER) -h$(PG_HOST) -p$(PG_PORT) $(PG_DATABASE)

reset:
	@PGPASSWORD=$(PG_PASS) psql -U$(PG_USER) -h$(PG_HOST) -p$(PG_PORT) postgres -c "DROP DATABASE IF EXISTS $(PG_DATABASE)";
	@PGPASSWORD=$(PG_PASS) psql -U$(PG_USER) -h$(PG_HOST) -p$(PG_PORT) postgres -c "CREATE DATABASE $(PG_DATABASE) OWNER $(PG_USER)";
	@PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) ${PG_DATABASE} --command "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
	@PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) ${PG_DATABASE} --command "CREATE EXTENSION IF NOT EXISTS \"pg_trgm\";"
	cat *.sql | PGPASSWORD=$(PG_PASS) psql -U$(PG_USER) -h$(PG_HOST) -p$(PG_PORT) $(PG_DATABASE);

schema:
	@PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) $(PG_DATABASE) --command "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
	cat 000*.sql | PGPASSWORD=$(PG_PASS) psql -U$(PG_USER) -h$(PG_HOST) -p$(PG_PORT) $(PG_DATABASE);

schema-ci:
	@PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -p$(PG_PORT) $(PG_DATABASE) --command "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
	cat 000*.sql | PGPASSWORD=$(PG_PASS) psql -U$(PG_USER) -p$(PG_PORT) $(PG_DATABASE);

init:
	@PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) --command "CREATE USER $(PG_USER) WITH PASSWORD '$(PG_PASS)';" && \
	PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) --command "CREATE DATABASE $(PG_DATABASE) OWNER $(PG_USER);" && \
	PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) --command "ALTER USER $(PG_USER) CREATEDB;" && \
	PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) --command "GRANT ALL PRIVILEGES ON DATABASE $(PG_DATABASE) TO $(PG_USER);"

drop:
	psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) --command "DROP DATABASE IF EXISTS $(PG_DATABASE);" && \
	psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) --command "DROP ROLE IF EXISTS $(PG_USER);"

backup:
	@PGPASSWORD=$(PG_PASS) pg_dump -U$(PG_USER) -h$(PG_HOST) -p$(PG_PORT) $(PG_DATABASE) > 0000_schema.sql;

revoke:
	@PGPASSWORD=$(PG_ROOT_PASS) psql -U$(PG_ROOT) -h$(PG_HOST) -p$(PG_PORT) --command "SELECT pg_terminate_backend(pid) \
		           FROM pg_stat_activity WHERE pid <> pg_backend_pid() AND datname = '$(PG_DATABASE)';"
