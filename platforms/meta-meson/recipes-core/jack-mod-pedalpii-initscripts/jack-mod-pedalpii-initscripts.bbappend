
FILES_${PN}-jackd_append = " ${sysconfdir}/default/jackd "

do_install_append() {
        install -d ${D}${sysconfdir}/default
        echo "

OPTIONS=\" -P70 -p256 -t2000 -d alsa -P hw:0,0 -C hw:0,3 -p 128 -n 2 -r 48000 -s -i2 -o2 \"

" >> ${D}${sysconfdir}/default/jackd
}

