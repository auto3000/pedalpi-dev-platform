# Standard pedalpi configuration defaults, inherited by all targets

PACKAGE_CLASSES ?= "package_deb"
EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
USER_CLASSES ?= "buildstats image-mklibs image-prelink"
PATCHRESOLVE ?= "noop"
LICENSE_FLAGS_WHITELIST  += "commercial"

