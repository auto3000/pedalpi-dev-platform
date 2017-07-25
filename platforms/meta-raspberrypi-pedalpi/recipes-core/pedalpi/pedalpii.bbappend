
# wiringpi is not required, but it provides 'gpio' utility that could help
# for diagnostics
RDEPENDS_${PN} += " python3-rpi-gpio wiringpi "

FILES_${PN}_append = " ${sysconfdir}/default "

do_install_append() {
	install -d ${D}${sysconfdir}/default
	echo "export RPI_GPIO_CONNECTED=1" >> ${D}${sysconfdir}/default/pedalpII
}

