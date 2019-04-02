FROM crops/yocto:ubuntu-14.04-builder
MAINTAINER auto3000;

ENTRYPOINT []

USER root
CMD /bin/bash

# Install prerequisites
RUN apt-get update && apt-get install -y \
curl
RUN useradd -m -u 1001 vsts_azpcontainer

USER vsts_azpcontainer 
