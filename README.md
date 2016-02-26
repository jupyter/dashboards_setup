Deploys a tmpnb site running Juptyer Notebook with the jupyter_dashboards, jupyter_dashboards_bundlers, jupyter_declarativewidgets, and jupyter_cms extensions pre-installed along with a bunch of demos notebooks.

The site at http://jupyter.cloudet.xyz is a sample deployment.

To bring it up the first time:

```bash
# point docker to your favorite docker host
eval $(docker-machine env your_docker_host)

# build the notebook image from the Dockerfile
make dev-image

# run one container instance to try it on port 9500
make dev

# when the image works, tag it for use in the tmpnb cluster
# if the cluster is running, this will also drain off old containers not in use
# and replace them with containers based on the new image
make prod-image

# start the tmpnb proxy and container pool with a default of 1 GB RAM allocated
# for each container and 64 containers
make tmpnb TOKEN=$(openssl rand -base64 32)
```

If there's changes to the Dockerfile:

```bash
make dev-image
make dev
# when satisfied it works, drain off the old and fire up the new
make prod-image
```

To kill the entire cluster:

```bash
make nuke
```
