
FILES_${PN}-jackd_append = " ${sysconfdir}/default/jackd "

do_install_append() {
        install -d ${D}${sysconfdir}/default
        echo "
logger 'Setup the Mic1 for input volume.'
amixer set Mic1 Playback 5 |logger
logger 'Setup the Mic1 Boost for line db levels input. You can now plug your guitar.'
amixer set 'Mic1 Boost' 0 |logger
logger 'Enable capture on Mic1. Without this command, no sample data are read.'
amixer set Mic1 cap |logger 
" >> ${D}${sysconfdir}/default/jackd
}

