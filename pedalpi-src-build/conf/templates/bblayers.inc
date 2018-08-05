BBPATH = "${TOPDIR}"
BBFILES ?= ""

BBLAYERS ?= " \
  ${TOPDIR}/../poky/meta \
  ${TOPDIR}/../poky/meta-poky \
  ${TOPDIR}/../poky/meta-yocto-bsp \
  ${TOPDIR}/../meta-openembedded/meta-oe \
  ${TOPDIR}/../meta-openembedded/meta-multimedia \
  ${TOPDIR}/../meta-openembedded/meta-networking \
  ${TOPDIR}/../meta-openembedded/meta-python \
  ${TOPDIR}/../meta-openembedded/meta-ruby \
  ${TOPDIR}/../meta-qt5/ \
  ${TOPDIR}/../meta-pedalpi/ \
  ${TOPDIR}/../platforms/meta-common \
  "

