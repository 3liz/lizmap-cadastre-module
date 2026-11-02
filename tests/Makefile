SHELL = bash
.ONESHELL:
.PHONY: env
#

LIZMAP_DIR=$(shell pwd)/lizmap

LIZMAP_USER_ID:=$(shell id -u)
LIZMAP_USER_GID:=$(shell id -g)

LIZMAP_VERSION_TAG:=3.9
QGIS_VERSION_TAG:=ltr-rc
POSTGIS_VERSION_TAG:=17-3

QGIS_MAP_WORKERS:=1

LIZMAP_PORT:=127.0.0.1:9085
OWS_PORT:=127.0.0.1:9086
LZMPGPORT:=127.0.0.1:9087

MODULE_SRC:=$(shell realpath ..)

# QGIS Desktop image used to import the test data, same QGIS version as QGIS Server
QGIS_PLATFORM_TAG:=3.44

# QGIS plugin cadastre, used by QGIS Server and for the test data (they are not in the published plugin).
# * CADASTRE_PLUGIN_SRC set: path of a local clone of the plugin, to test changes of the plugin before pushing them.
#   Set it in the environment, or in tests/.localconfig.mk: CADASTRE_PLUGIN_SRC=/path/to/QgisCadastrePlugin
# * Otherwise: the branch or tag CADASTRE_PLUGIN_REF of the plugin repository is cloned in lizmap/cadastre-plugin.
-include .localconfig.mk
CADASTRE_PLUGIN_REPOSITORY?=https://github.com/3liz/QgisCadastrePlugin.git
CADASTRE_PLUGIN_REF?=master
ifeq ($(CADASTRE_PLUGIN_SRC),)
CADASTRE_PLUGIN_CLONE:=$(LIZMAP_DIR)/cadastre-plugin
CADASTRE_PLUGIN_SRC:=$(CADASTRE_PLUGIN_CLONE)
endif

COMPOSE_FILE:=docker-compose.yml:docker-compose.plugin.yml

# Name of the docker compose project: the containers and the PostgreSQL volume are shared by all the clones
# of the module using the same name, and 'make clean' deletes this volume
COMPOSE_PROJECT_NAME?=cadastre

main:
	@cat <<- EOF
		Commandes:
			run:   initialise environnement and run stack
			stop:  stop docker and remove containers
			clean: reset containers and remove lizmap configuration
			shell: open a shell in Lizmap web container
			install-plugins: install QGIS Server plugins
			import-data: import test data inside the PostgreSQL database
			plugin-src: clone or update the plugin cadastre, if CADASTRE_PLUGIN_SRC is not set
			import-test-data: import the fictitious test data of the plugin cadastre
			test:  run the tests of the module, on a running stack with the test data
			ci:    run the stack, install the module, the test data and the rights, then run the tests

			Note: Un fichier d'environment pour docker compose
			est crée à chaque invocation de 'run'.
			Cela permet d'utiliser les commandes 'docker compose'
			sans passer par le Makefile
	EOF

dirs:
	@mkdir -p $(LIZMAP_DIR)/var/log/nginx \
		      $(LIZMAP_DIR)/var/nginx-cache \
		      $(LIZMAP_DIR)/qgis-server-plugins \
		      $(LIZMAP_DIR)/qgis-server-plugins/cadastre \
		      $(LIZMAP_DIR)/local-python \
		      $(LIZMAP_DIR)/cache-python \
		      $*

env: dirs
	@cat <<- EOF > .env
		COMPOSE_PROJECT_NAME=$(COMPOSE_PROJECT_NAME)
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
		QGIS_PLATFORM_TAG=$(QGIS_PLATFORM_TAG)
		CADASTRE_PLUGIN_SRC=$(CADASTRE_PLUGIN_SRC)
		COMPOSE_FILE=$(COMPOSE_FILE)
		EOF

run: stop env install-plugins plugin-src
	# Wait for the healthchecks of the services: the stack is ready for install-module
	docker compose up -d --wait

plugin-src:
ifdef CADASTRE_PLUGIN_CLONE
	@echo "Plugin cadastre: $(CADASTRE_PLUGIN_REF) of $(CADASTRE_PLUGIN_REPOSITORY)"
	@if [ -d "$(CADASTRE_PLUGIN_CLONE)/.git" ]; then \
		git -C "$(CADASTRE_PLUGIN_CLONE)" fetch -q --depth 1 origin "$(CADASTRE_PLUGIN_REF)" && \
		git -C "$(CADASTRE_PLUGIN_CLONE)" checkout -q --detach FETCH_HEAD; \
	else \
		git clone -q --depth 1 --branch "$(CADASTRE_PLUGIN_REF)" "$(CADASTRE_PLUGIN_REPOSITORY)" "$(CADASTRE_PLUGIN_CLONE)"; \
	fi
	@git -C "$(CADASTRE_PLUGIN_CLONE)" log -1 --format="Plugin cadastre: commit %h %s"
else
	@echo "Plugin cadastre: local clone $(CADASTRE_PLUGIN_SRC)"
endif

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
		    echo 'https://plugins.qgis.org/plugins/plugins.xml?qgis=[VERSION]' > /tmp/sources-plugin-manager.list
		    qgis-plugin-manager update
		    qgis-plugin-manager install 'Lizmap server'
		    qgis-plugin-manager install atlasprint
		    qgis-plugin-manager install wfsOutputExtension
		"

import-data:
	sql/import.sh

import-test-data: env
	@if [ ! -d "$(CADASTRE_PLUGIN_SRC)/tests/fixtures" ]; then echo "No plugin in $(CADASTRE_PLUGIN_SRC): make plugin-src"; exit 1; fi
	docker compose --profile tools run --rm qgis-tools

ci: run install-module import-test-data import-lizmap-acl test

test:
	LIZMAP_URL=http://$(LIZMAP_PORT) uv run --no-project --with pytest --with requests pytest -v api

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
	@echo "Cadastre: search for everybody, owners without birth data for users, full data for admins"
	@echo "The rights on the owners are global: the module does not check them on a repository"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php acl2:add __anonymous "cadastre.use.search.tool" tests ; \
		php lizmap/console.php acl2:add users "cadastre.use.search.tool" tests ; \
		php lizmap/console.php acl2:add admins "cadastre.use.search.tool" tests ; \
		php lizmap/console.php acl2:add users "cadastre.acces.donnees.proprio.simple" ; \
		php lizmap/console.php acl2:add admins "cadastre.acces.donnees.proprio"'
	@echo "Add the user 'cadastre', in the group 'users'"
	docker compose exec -u $(LIZMAP_USER_ID) lizmap /bin/sh -c ' \
		php lizmap/console.php jcommunity:user:create --no-error-if-exist cadastre cadastre@lizmap.local cadastre ; \
		php lizmap/console.php acl2user:list | grep -q " cadastre " || php lizmap/console.php acl2user:register cadastre ; \
		php lizmap/console.php acl2user:list | grep " cadastre " | grep -q " users " || php lizmap/console.php acl2user:addgroup cadastre users'

install-module:
	docker compose exec -u ${LIZMAP_USER_ID} lizmap php /www/lizmap/install/configurator.php cadastre
	docker compose exec -u ${LIZMAP_USER_ID} lizmap php /www/lizmap/install/installer.php -v --no-clean-temp
	docker compose exec  lizmap /www/lizmap/install/clean_vartmp.sh
