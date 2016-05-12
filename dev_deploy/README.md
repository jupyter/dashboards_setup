This folder contains a recipe for local testing of the end-to-end workflow of writing notebooks, adding declarative widgets to them, laying them out as dashboards, bundling them for deployment, and viewing them on a dashboard server. By default, it uses a stable releases for each component, but has the ability to replace most components with development snapshots either from PyPI/npm or local source trees.

## Prerequisites

* Docker Compose 1.6.0+
* Docker Engine 1.10.0+
* Docker Machine 0.6.0+ (or suitable docker environment)

## Setup

```
eval $(docker-machine env your_host)

git clone https://github.com/jupyter-incubator/dashboards_setup
cd dashboards_setup/dev_deploy

# if you want to git clone every dashboard related project all at once
# otherwise, git clone them or your forks yourself as child directories under
# dev_deploy

make clones
```

## Run with all stable versions

```
cd dashboards_setup/dev_deploy
docker-compose build  # add --no-cache --force-rm if switching versions
docker-compose up
```

## Run with some development versions

As example, say we wanted to use the code from our local `jupyter-incubator/dashboards` and `jupyter-incubator/dashboards_server` sandboxes alongside stable versions of everything else. We could do the following:

```
# build a source distribution of the dashboards project
cd dashboards_setup/dev_deploy

pushd dashboards
make build js sdist
popd

pushd dashboards_server
npm install
gulp build
popd

# edit docker-compose.yml, in the notebooks section, set:
# args:
#   DASHBOARDS: /src/jupyter_dashboards-0.6.0.dev0.tar.gz
# and in the dashboards section, set:
# args:
#   DASHBOARDS_SERVER: /src

# then ...
make build
make run
```

See the `build.args` sections in `docker-compose.yml` for the full list of components that you can replace with development versions. Note also that the `kernel_gateway` service and the `notebook` service share the `/home/jovyan/work` volume. This makes testing of notebook-dashboards that use local data files in that volume easier.

## Try it

After running the above, open a browser to `http://<your docker host IP>:8888` to access the notebook server. Open the hello world notebook, run it, switch to dashboard mode to see it working. Then use the *File &rarr; Deploy As &rarr; Dashboard on Jupyter Dashboard Server*. After deploying, the notebook server will automatically redirect you to the dashboard server running on `http://<your docker host IP>:3000`. Login with `demo` as the username and password.

If you want to run the `taxi_demo_grid` or `meetup-streaming` notebooks on the dashboard server, make sure you run them first in the notebook server so that all of the declarative widgets are available for deployment.
