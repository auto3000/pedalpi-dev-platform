# Standard pedalpi configuration defaults, inherited by all targets

EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
USER_CLASSES ?= "buildstats image-mklibs image-prelink"
PATCHRESOLVE ?= "noop"
LICENSE_FLAGS_WHITELIST  += "commercial"

# Enable fortran
FORTRAN_forcevariable = ",fortran"
RUNTIMETARGET_append_pn-gcc-runtime = " libquadmath"

SSTATE_MIRRORS = "\
file://.* http://sstate.yoctoproject.org/2.2/PATH;downloadfilename=PATH \n \
file://.* http://sstate.yoctoproject.org/dev/PATH;downloadfilename=PATH \n \
"


