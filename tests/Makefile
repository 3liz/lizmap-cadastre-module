SHELL = bash
.ONESHELL:
.PHONY: env
#

LIZMAP_DIR=$(shell pwd)/lizmap

LIZMAP_USER_ID:=$(shell id -u)
LIZMAP_USER_GID:=$(shell id -g)

LIZMAP_VERSION_TAG:=3.5
QGIS_VERSION_TAG:=ltr-rc
POSTGIS_VERSION_TAG:=13-3

QGIS_MAP_WORKERS:=1

LIZMAP_PORT:=127.0.0.1:9085
OWS_PORT:=127.0.0.1:9086
LZMPGPORT:=127.0.0.1:9087

MODULE_SRC:=$(shell realpath ..)

main:
	@cat <<- EOF
		Commandes:
			run:   initialise environnement and run stack
			stop:  stop docker and remove containers
			clean: reset containers and remove lizmap configuration
			shell: open a shell in Lizmap web container
			install-plugins: install QGIS Server plugins
			import-data: import test data inside the PostgreSQL database

			Note: Un fichier d'environment pour docker compose
			est crée à chaque invocation de 'run'.
			Cela permet d'utiliser les commandes 'docker compose'
			sans passer par le Makefile
	EOF

dirs:
	@mkdir -p $(LIZMAP_DIR)/var/log/nginx \
		      $(LIZMAP_DIR)/var/nginx-cache \
		      $(LIZMAP_DIR)/qgis-server-plugins \
		      $(LIZMAP_DIR)/local-python \
		      $(LIZMAP_DIR)/cache-python \
		      $*

env: dirs
	@cat <<- EOF > .env
		COMPOSE_PROJECT_NAME=cadastre
		LIZMAP_DIR=$(LIZMAP_DIR)
		LIZMAP_USER_ID=$(LIZMAP_USER_ID)
		LIZMAP_USER_GID=$(LIZMAP_USER_GID)
		QGIS_MAP_WORKERS=$(QGIS_MAP_WORKERS)
		LIZMAP_PORT=$(LIZMAP_PORT)
		OWS_PORT=$(OWS_PORT)
		LZMPGPORT=$(LZMPGPORT)
		MODULE_SRC=$(MODULE_SRC)
		LIZMAP_VERSION_TAG=$(LIZMAP_VERSION_TAG)
		QGIS_VERSION_TAG=$(QGIS_VERSION_TAG)
		POSTGIS_VERSION_TAG=$(POSTGIS_VERSION_TAG)
		EOF

run: stop env install-plugins
	docker compose up -d

stop:
	docker compose down || true

clean: stop
	docker compose down -v
	rm -rf $(LIZMAP_DIR)/www/*
	rm -rf $(LIZMAP_DIR)/var/*

# Pull images from github 3liz
pull:
	docker pull 3liz/lizmap-web-client:${LIZMAP_VERSION_TAG}
	docker pull 3liz/qgis-map-server:${QGIS_VERSION_TAG}
	docker pull 3liz/postgis:${POSTGIS_VERSION_TAG}

shell:
	docker compose exec -u ${LIZMAP_USER_ID} lizmap /bin/sh -l

install-plugins: dirs
	@echo "Install QGIS server plugins"
	docker run \
		-u $(LIZMAP_USER_ID):$(LIZMAP_USER_GID) \
		--rm -i \
		-e QGSRV_SERVER_PLUGINPATH=/srv/plugins \
		-e QGIS_PLUGIN_MANAGER_SOURCES_FILE=/tmp/sources-plugin-manager.list \
		-e QGIS_PLUGIN_MANAGER_CACHE_DIR=/tmp/cache-plugin-manager \
		-v $(LIZMAP_DIR)/qgis-server-plugins:/srv/plugins \
		-v $(shell pwd)/:/src \
		--entrypoint /bin/bash \
		3liz/qgis-map-server:$(QGIS_VERSION_TAG) \
		-c "
		    echo "https://packages.3liz.org/pub/server-plugins-repository/unstable/plugins.[VERSION].xml" > /tmp/sources-plugin-manager.list
		    qgis-plugin-manager update
		    qgis-plugin-manager install 'Lizmap server'
		    qgis-plugin-manager install atlasprint
		    qgis-plugin-manager install wfsOutputExtension
		    qgis-plugin-manager install cadastre
		"

import-data:
	sql/import.sh

import-lizmap-acl-35:
	@echo "Set repositories and users rights if needed"
	@echo "Set view project"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/cmd.php acl2right add __anonymous "lizmap.repositories.view" tests ; \
		php lizmap/cmd.php acl2right add users "lizmap.repositories.view" tests ; \
		php lizmap/cmd.php acl2right add admins "lizmap.repositories.view" tests'
	@echo "Display WMS links"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/cmd.php acl2right add __anonymous "lizmap.tools.displayGetCapabilitiesLinks" tests ; \
		php lizmap/cmd.php acl2right add users "lizmap.tools.displayGetCapabilitiesLinks" tests ; \
		php lizmap/cmd.php acl2right add admins "lizmap.tools.displayGetCapabilitiesLinks" tests'
	@echo "Edition"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/cmd.php acl2right add __anonymous "lizmap.tools.edition.use" tests ; \
		php lizmap/cmd.php acl2right add users "lizmap.tools.edition.use" tests ; \
		php lizmap/cmd.php acl2right add admins "lizmap.tools.edition.use" tests'
	@echo "Export layers"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/cmd.php acl2right add __anonymous "lizmap.tools.layer.export" tests ; \
		php lizmap/cmd.php acl2right add users "lizmap.tools.layer.export" tests ; \
		php lizmap/cmd.php acl2right add admins "lizmap.tools.layer.export" tests'
	@echo "Cadastre"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/cmd.php acl2right add __anonymous "cadastre.use.search.tool"; \
		php lizmap/cmd.php acl2right add users "cadastre.use.search.tool"; \
		php lizmap/cmd.php acl2right add admins "cadastre.use.search.tool"; \
		php lizmap/cmd.php acl2right add users "cadastre.acces.donnees.proprio.simple"; \
		php lizmap/cmd.php acl2right add admins "cadastre.acces.donnees.proprio.simple"; \
		php lizmap/cmd.php acl2right add admins "cadastre.acces.donnees.proprio"'
	@echo "Add 'cadastre' user"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/scripts/script.php jcommunity~user:create -v --no-error-if-exists cadastre cadastre@lizmap.local cadastre'

import-lizmap-acl:
	@echo "Set repositories and users rights if needed"
	@echo "Set view project"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php acl2:add __anonymous "lizmap.repositories.view" tests ; \
		php lizmap/console.php acl2:add users "lizmap.repositories.view" tests ; \
		php lizmap/console.php acl2:add admins "lizmap.repositories.view" tests'
	@echo "Display WMS links"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php acl2:add __anonymous "lizmap.tools.displayGetCapabilitiesLinks" tests ; \
		php lizmap/console.php acl2:add users "lizmap.tools.displayGetCapabilitiesLinks" tests ; \
		php lizmap/console.php acl2:add admins "lizmap.tools.displayGetCapabilitiesLinks" tests'
	@echo "Edition"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php acl2:add __anonymous "lizmap.tools.edition.use" tests ; \
		php lizmap/console.php acl2:add users "lizmap.tools.edition.use" tests ; \
		php lizmap/console.php acl2:add admins "lizmap.tools.edition.use" tests'
	@echo "Export layers"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php acl2:add __anonymous "lizmap.tools.layer.export" tests ; \
		php lizmap/console.php acl2:add users "lizmap.tools.layer.export" tests ; \
		php lizmap/console.php acl2:add admins "lizmap.tools.layer.export" tests'
	@echo "Cadastre"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php acl2:add __anonymous "cadastre.acces.donnees.proprio" tests ; \
		php lizmap/console.php acl2:add users "cadastre.acces.donnees.proprio" tests ; \
		php lizmap/console.php acl2:add admins "cadastre.acces.donnees.proprio" tests'
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php acl2:add __anonymous "cadastre.use.search.tool" tests ; \
		php lizmap/console.php acl2:add users "cadastre.use.search.tool" tests ; \
		php lizmap/console.php acl2:add admins "cadastre.use.search.tool" tests'

install-module:
	docker compose exec -u ${LIZMAP_USER_ID} lizmap php /www/lizmap/install/configurator.php cadastre
	docker compose exec -u ${LIZMAP_USER_ID} lizmap php /www/lizmap/install/installer.php -v --no-clean-temp
	docker compose exec  lizmap /www/lizmap/install/clean_vartmp.sh
