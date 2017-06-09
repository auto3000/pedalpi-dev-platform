# LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf
# changes incompatibly

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BBLAYERS ?= " \
  ${TOPDIR}/../poky/meta \
  ${TOPDIR}/../poky/meta-yocto \
  ${TOPDIR}/../poky/meta-yocto-bsp \
  ${TOPDIR}/../meta-openembedded/meta-oe \
  ${TOPDIR}/../meta-openembedded/meta-filesystems \
  ${TOPDIR}/../meta-openembedded/meta-python \
  ${TOPDIR}/../meta-pedalpi/ \
  "

BBLAYERS_NON_REMOVABLE ?= " \
  ${OEROOT}/meta \
  ${OEROOT}/meta-yocto \
  "
