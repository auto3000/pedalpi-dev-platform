
RDEPENDS_${PN} += " python3-rpi-gpio-np "

FILES_${PN}_append = " ${sysconfdir}/default "

do_install_append() {
	install -d ${D}${sysconfdir}/default
	echo "export RPI_GPIO_CONNECTED=1" >> ${D}${sysconfdir}/default/pedalpII
}

