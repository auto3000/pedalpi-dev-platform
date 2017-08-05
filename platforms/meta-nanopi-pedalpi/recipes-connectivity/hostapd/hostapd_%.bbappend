FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://hostapd.conf \
    file://default \
"

do_install_append() {
    install -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/default ${D}${sysconfdir}/default/hostapd
    install -m 0644 ${WORKDIR}/hostapd.conf ${D}${sysconfdir}/hostapd.conf
}

