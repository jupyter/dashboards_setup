# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

FROM node:6

# Add our user and group first to make sure their IDs get assigned consistently
RUN groupadd -r app && useradd -r -g app app 

# Create a directory which will contain notebooks
RUN mkdir -p /srv/app/data && chown -R app:app /srv/app 
ENV NOTEBOOKS_DIR /srv/app/data

# Always expose server on all interfaces in a container
ENV IP 0.0.0.0
# Expose the default express http/https port (3000/3001)
EXPOSE 3000 3001

# Allow override of dashboard package version
ARG DASHBOARDS_SERVER_VER

# Install the dashboard server as root so that the files are protected.
# npm throws an error when installing a dependency, because we
# are root. This setting works around that issue.
RUN npm config set unsafe-perm true && \
    npm install -g jupyter-dashboards-server@"$DASHBOARDS_SERVER_VER" && \
    npm config set unsafe-perm false
    
# run as unprivileged user
USER app
WORKDIR /srv/app
CMD ["jupyter-dashboards-server"]
