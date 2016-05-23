# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
.PHONY: help clones dist_dirs build kill run

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clones: contentmanagement dashboards dashboards_bundlers dashboards_server declarativewidgets

contentmanagement:
	git clone git@github.com:jupyter-incubator/contentmanagement.git
dashboards:
	git clone git@github.com:jupyter-incubator/dashboards.git
dashboards_bundlers:
	git clone git@github.com:jupyter-incubator/dashboards_bundlers.git
dashboards_server:
	git clone git@github.com:jupyter-incubator/dashboards_server.git
declarativewidgets:
	git clone git@github.com:jupyter-incubator/declarativewidgets.git

dist_dirs: clones
	@mkdir -p contentmanagement/dist
	@mkdir -p dashboards/dist
	@mkdir -p dashboards_bundlers/dist
	@mkdir -p declarativewidgets/dist

build: dist_dirs ## Builds the various docker images
	docker-compose build

run: ## Run the docker containers
	docker-compose up

kill: ## Kill the running, possibly leftover, docker containers
	docker-compose kill

nuke: ## Remove the built docker images
	docker-compose down --rmi all
