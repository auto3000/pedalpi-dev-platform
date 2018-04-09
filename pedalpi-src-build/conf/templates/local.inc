# Standard pedalpi configuration defaults, inherited by all targets

EXTRA_IMAGE_FEATURES ?= "debug-tweaks"
USER_CLASSES ?= "buildstats image-mklibs image-prelink"
PATCHRESOLVE ?= "noop"
LICENSE_FLAGS_WHITELIST  += "commercial"

# Enable fortran
FORTRAN_forcevariable = ",fortran"
RUNTIMETARGET_append_pn-gcc-runtime = " libquadmath"

DISTRO_FEATURES_remove = " wayland opengl pulseaudio opengles egl"
PACKAGECONFIG_pn-qtwebkit = " fontconfig "
PACKAGECONFIG_DEFAULT_pn-qtbase_remove = " dbus udev evdev "
PACKAGECONFIG_DEFAULT_pn-qtbase_append = " fontconfig "

QT_CONFIG_FLAGS_pn-qtbase_append = " -qt-zlib \
             -qt-libpng \
             -qt-libjpeg \
             -qt-pcre \
             -nomake examples \
             -nomake tools \
             -nomake tests \
             -no-audio-backend \
             -no-dbus \
             -no-gstreamer \
             -no-journald \
             -no-opengl \
             -no-qml-debug \
             -no-sql-db2 \
             -no-sql-ibase \
             -no-sql-mysql \
             -no-sql-oci \
             -no-sql-odbc \
             -no-sql-psql \
             -no-sql-sqlite \
             -no-sql-sqlite2 \
             -no-sql-tds \
             -no-tslib "
