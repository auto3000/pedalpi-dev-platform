FROM crops/yocto:ubuntu-14.04-builder
MAINTAINER auto3000;

ENTRYPOINT []

USER root
CMD /bin/bash

# Install prerequisites
RUN apt-get update && apt-get install -y \
curl

USER yoctouser
WORKDIR /home/yoctouser
CMD /bin/bash
