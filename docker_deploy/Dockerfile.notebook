# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# Pin to a known release for sanity
FROM jupyter/pyspark-notebook:8015c88c4b11

# Become root to do the apt-gets
USER root

RUN apt-get update && \
		apt-get install -y curl && \
		curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash - && \
		apt-get install --yes nodejs && \
		npm install -g bower

# Do the pip installs as the unprivileged notebook user
USER jovyan

# Install dashboard layout and preview within Jupyter Notebook
ARG DASHBOARDS_VER
RUN pip install "jupyter_dashboards==$DASHBOARDS_VER" && \
	jupyter dashboards quick-setup --sys-prefix

# Install declarative widgets for Jupyter Notebook
ARG DECLWIDGETS_VER
RUN pip install "jupyter_declarativewidgets==$DECLWIDGETS_VER" && \
	jupyter declarativewidgets quick-setup --sys-prefix

# Install content management to support dashboard bundler options
ARG CMS_VER
ARG BUNDLER_VER
RUN pip install "jupyter_cms==$CMS_VER" && \
	jupyter cms quick-setup --sys-prefix
RUN pip install "jupyter_dashboards_bundlers==$BUNDLER_VER" && \
	jupyter dashboards_bundlers quick-setup --sys-prefix

# Put a couple sample notebooks into the notebook server
RUN wget -O $HOME/work/hello_world.ipynb https://gist.githubusercontent.com/parente/bd6789c4a3533fab8085/raw/c5a8e9be2213650332889178b15cf899a844694f/hello_world.ipynb
RUN wget -O $HOME/work/meetup-streaming.ipynb https://raw.githubusercontent.com/jupyter-incubator/dashboards/master/etc/notebooks/stream_demo/meetup-streaming.ipynb

# Stay as jovyan in the newer docker stack images
