# [RETIRED] Jupyter Dashboards Setup

**This project has been retired.** See the [proposal to move the project to jupyter-attic](https://github.com/jupyter/enhancement-proposals/blob/master/jupyter-dashboards-deployment-attic/jupyter-dashboards-deployment-attic.md), [announcement of the proposal on the mailing list](https://groups.google.com/forum/#!topic/jupyter/icEtCVLniRc), and [Steering Council vote on the proposal PR](https://github.com/jupyter/enhancement-proposals/pull/22) for more information.

----

Contains recipes for setting up dashboard-related projects using various technologies (e.g., tmpnb, Docker, Cloud Foundry). See the README in each subfolder for additional information.

* [cf_deploy](cf_deploy/) - Linked dashboard and kernel gateway servers on Cloud Foundry using stable releases
* [dev_deploy](dev_deploy/) - Linked notebook, dashboard, and kernel gateway servers in Docker with option to use local source builds for integrated dev/test
* [docker_deploy](docker_deploy/) - Linked notebook, dashboard, and kernel gateway servers in Docker using stable releases
* [tmpnb_deploy](tmpnb_deploy/) - Temporary notebook servers with stable extension releases pre-installed
