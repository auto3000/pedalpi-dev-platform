
FILES_${PN}-jackd_append = " ${sysconfdir}/default/jackd "

do_install_append() {
        install -d ${D}${sysconfdir}/default
        echo "
# Enable capture on nanopi neo air. Without this command, no
# sample data are read.
amixer set Mic1 cap |logger 
" >> ${D}${sysconfdir}/default/jackd
}

