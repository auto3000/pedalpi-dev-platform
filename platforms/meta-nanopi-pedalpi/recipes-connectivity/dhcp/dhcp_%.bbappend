FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://dhcpd.conf \
	file://dhcp-server \
"

do_install_append () {
        rm -f ${D}${sysconfdir}/dhcpd.conf*
        install -m 0644 ${WORKDIR}/dhcpd.conf ${D}${sysconfdir}/dhcp/dhcpd.conf
	install -m 0644 ${WORKDIR}/dhcp-server ${D}${sysconfdir}/default/dhcp-server
}
