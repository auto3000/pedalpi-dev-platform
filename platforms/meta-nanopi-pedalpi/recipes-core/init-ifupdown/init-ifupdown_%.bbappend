FILESEXTRAPATHS_prepend := "${THISDIR}:"

SRC_URI_append = " \
	file://interfaces-wlan0-ap \
"

# Replace previously installed interfaces file with the one that allows for an AP
do_install_append () {
	rm ${D}${sysconfdir}/network/interfaces
        install -m 0644 ${WORKDIR}/interfaces-wlan0-ap ${D}${sysconfdir}/network/interfaces
}

