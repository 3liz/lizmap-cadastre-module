# Run docker compose

## Automated tests, with the fictitious data of the QGIS plugin

QGIS Server runs the code of the [QGIS plugin cadastre](https://github.com/3liz/QgisCadastrePlugin) from
its git repository, which also contains its fictitious test data (EDIGEO and MAJIC of the commune 13029,
**all the owners, births, addresses and values are invented**). They are imported in the schema
`cadastre_tests`, with the project `cadastre_tests.qgs`.

By default, `make run` clones the branch `master` of the plugin in `lizmap/cadastre-plugin`, and updates it
at each run. Another branch or tag can be used:

```bash
make run CADASTRE_PLUGIN_REF=2.4.0
```

To test changes of the plugin before pushing them, use a local clone of the plugin instead. Set its path in
`tests/.localconfig.mk` (not versioned), or in the environment:

```bash
echo "CADASTRE_PLUGIN_SRC=/path/to/QgisCadastrePlugin" > .localconfig.mk
```

Then:

```bash
make run
make install-module
make import-test-data
make import-lizmap-acl
make test
```

* `make import-test-data` imports the data with the import of the plugin itself, in a QGIS Desktop
  container (`3liz/qgis-platform`, same QGIS version as QGIS Server), and creates the project
  `cadastre_tests.qgs` from `cadastre_caen.qgs`. It can be run again, it replaces the schema.
* `make import-lizmap-acl` creates the user `cadastre` (password `cadastre`) in the group `users`,
  with the owners data without birth data. The user `admin` has all the owners data.
* `make test` runs the tests of `tests/api` with [uv](https://docs.astral.sh/uv/): they call the
  module like the browser, as anonymous, `cadastre` and `admin`.

## Manual tests

Steps:

- Launch Lizmap with docker compose

```bash
# Clean previous versions (optional)
make clean

# Run the different services (with lizmap 3.9)
make run

# or with a specific version of Lizmap
make run LIZMAP_VERSION_TAG=3.8

# then execute to have a complete tests environment
make install-module
make import-data
make import-lizmap-acl
```

- Open your browser at http://localhost:9085
- You can authenticate as `admin` or `cadastre` (the password is the same as the login)

You can update docker images with

```bash
make pull

# or with a specific version of Lizmap
make pull LIZMAP_VERSION_TAG=3.8
```

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
