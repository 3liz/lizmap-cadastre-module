# Run docker compose

Steps:

- Launch Lizmap with docker compose

```bash
# Clean previous versions (optional)
make clean

# Run the different services
make run
make import-data
make import-lizmap-acl
```

- Open your browser at http://localhost:9085

For more information, refer to the [docker compose documentation](https://docs.docker.com/compose/)

## Access to the dockerized PostgreSQL instance

You can access the docker PostgreSQL test database `lizmap` from your host by configuring a
[service file](https://docs.qgis.org/latest/en/docs/user_manual/managing_data_source/opening_data.html#postgresql-service-connection-file).
The service file can be stored in your user home `~/.pg_service.conf` and should contain this section

```ini
[lizmap-cadastre]
dbname=lizmap
host=localhost
port=9086
user=lizmap
password=lizmap1234!
```

Then you can use any PostgreSQL client (psql, QGIS, PgAdmin, DBeaver) and use the `service`
instead of the other credentials (host, port, database name, user and password).

```bash
psql service=lizmap-tests
```

## Access to the lizmap container

If you want to enter into the lizmap container to execute some commands,
execute `make shell`.

## Add the test data

### PostgreSQL data

You can add some data in your docker test PostgreSQL database by running the SQL `tests/sql/test_data.sql`.

```bash
make import-data
```
or
```bash
psql service=lizmap-tests -f tests/sql/test_data.sql
```
