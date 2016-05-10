# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

clones:
	git clone git@github.com:jupyter-incubator/contentmanagement.git
	git clone git@github.com:jupyter-incubator/dashboards.git
	git clone git@github.com:jupyter-incubator/dashboards_bundlers.git
	git clone git@github.com:jupyter-incubator/dashboards_server.git
	git clone git@github.com:jupyter-incubator/declarativewidgets.git

dist_dirs:
	@mkdir -p contentmanagement/dist
	@mkdir -p dashboards/dist
	@mkdir -p dashboards_bundlers/dist
	@mkdir -p declarativewidgets/dist
	
build: dist_dirs
	docker-compose build
	
run:
	docker-compose up
