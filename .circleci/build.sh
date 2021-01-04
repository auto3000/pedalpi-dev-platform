#!/bin/bash

MACHINE=$1
TARGET=$2
RECIPE=${3:-"pedalpi-dev-platform"}

source init.sh ${MACHINE}
echo 'SCONF_VERSION = "1"' > conf/site.conf
echo 'SSTATE_DIR ?= "/tmp/sstate-cache"' >> conf/site.conf
echo 'DL_DIR ?= "/tmp/downloads"' >> conf/site.conf
if [[ $CIRCLE_JOB =~ .*step.* ]]; then
  timeout -k 7200 5600 bash -c "bitbake ${RECIPE} | cat -" || echo build is not finished yet
else
  bitbake ${RECIPE} | cat -
fi
mkdir -p /home/yoctouser/project/pedalpi-src-build/tmp/deploy/images/${TARGET}
date > /home/yoctouser/project/pedalpi-src-build/tmp/deploy/images/${TARGET}/sentinelle.txt

