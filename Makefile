# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

TMPNB_IMAGE:=jupyter/tmpnb@sha256:965bca52cb7660a2bb0532c6871d5744e9591283b6597ca992c80d960f7009ca
PROXY_IMAGE:=jupyter/configurable-http-proxy@sha256:f84940db7ddf324e35f1a5935070e36832cc5c1f498efba4d69d7b962eec5d08
NOTEBOOK_IMAGE:=jupyterincubator/dashboards-widgets-cm-notebook

MAX_LOG_SIZE:=50m
MAX_LOG_ROLLOVER:=10

help:
	@cat README.md

dev-image:
	@docker build --rm -t $(NOTEBOOK_IMAGE):dev .

prod-image:
	@docker tag -f $(NOTEBOOK_IMAGE):dev $(NOTEBOOK_IMAGE):latest
# Drain old idle containers after a successful notebook image build if the pool
# is already running.
	@-cat drain.py | docker exec -i tmpnb-pool python

dev:
	@docker run -it --rm -p 9500:8888 $(NOTEBOOK_IMAGE):dev

token-check:
	@test -n "$(TOKEN)" || \
		(echo "ERROR: TOKEN not defined (make help)"; exit 1)

proxy: token-check
	@docker run -d \
		--name=tmpnb-proxy \
		--log-driver=json-file \
		--log-opt max-size=$(MAX_LOG_SIZE) \
		--log-opt max-file=$(MAX_LOG_ROLLOVER) \
		-p 80:8000 \
		-e CONFIGPROXY_AUTH_TOKEN=$(TOKEN) \
		$(PROXY_IMAGE) \
			--default-target http://127.0.0.1:9999


pool: POOL_SIZE?=64
pool: MEMORY_LIMIT?=1024m
pool: BRIDGE_IP=$(shell docker inspect --format='{{.NetworkSettings.Networks.bridge.Gateway}}' tmpnb-proxy)
pool: token-check
	@docker run -d \
		--name=tmpnb-pool \
		--log-driver=json-file \
		--log-opt max-size=$(MAX_LOG_SIZE) \
		--log-opt max-file=$(MAX_LOG_ROLLOVER) \
		--net=container:tmpnb-proxy \
		-e CONFIGPROXY_AUTH_TOKEN=$(TOKEN) \
		-v /var/run/docker.sock:/docker.sock \
		$(TMPNB_IMAGE) \
		python orchestrate.py --image='$(NOTEBOOK_IMAGE):latest' \
			--container_user=jovyan \
			--cull_period=60 \
			--container_ip=$(BRIDGE_IP) \
			--pool_size=$(POOL_SIZE) \
			--redirect_uri=/notebooks/index.ipynb \
			--mem_limit=$(MEMORY_LIMIT) \
			--command='start-notebook.sh \
				--NotebookApp.base_url={base_path} \
				--ip=0.0.0.0 \
				--port={port} \
				--NotebookApp.trust_xheaders=True'

tmpnb: proxy pool

nuke:
	@-docker rm -f tmpnb-proxy
	@-docker rm -f tmpnb-pool
	@-docker rm -f $$(docker ps -a | grep 'tmp.jupyter' | awk '{print $$1}')
