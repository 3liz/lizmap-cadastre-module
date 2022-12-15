# Run docker compose

Steps:

- Launch Lizmap with docker compose

```bash
# Clean previous versions (optional)
make clean

# Run the different services (with lizmap 3.5)
make run

# or with a specific version of Lizmap
make run LIZMAP_VERSION_TAG=3.6.0-rc.2
```

If you are using Lizmap 3.6, execute:
```
make install-module
make import-data
make import-lizmap-acl
```

If you are using Lizmap 3.5, execute:
```
make import-data
make import-lizmap-acl-35
```

- Open your browser at http://localhost:9085
- You can authentify as `admin` or `cadastre` (the password is the same as the login)

## Access to the dockerized PostgreSQL instance

You can access the docker PostgreSQL test database `lizmap` from your host by configuring a
[service file](https://docs.qgis.org/latest/en/docs/user_manual/managing_data_source/opening_data.html#postgresql-service-connection-file).
The service file can be stored in your user home `~/.pg_service.conf` and should contain this section

```ini
[lizmap-cadastre]
dbname=lizmap
host=localhost
port=9087
user=lizmap
password=lizmap1234!
```

Then you can use any PostgreSQL client (psql, QGIS, PgAdmin, DBeaver) and use the `service`
instead of the other credentials (host, port, database name, user and password).

```bash
psql service=lizmap-cadastre
```

## Access to the lizmap container

If you want to enter into the lizmap container to execute some commands,
execute `make shell`.

## Add the test data

### Majic

You can provide some MAJIC SQL data in the `sql/majic`. There isn't MAJIC SQL data by default.

```bash
make import-data
```
or
```bash
psql service=lizmap-tests -f tests/sql/test_data.sql
```
