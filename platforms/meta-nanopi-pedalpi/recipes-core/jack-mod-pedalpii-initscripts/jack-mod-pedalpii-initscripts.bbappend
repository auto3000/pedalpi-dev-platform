
FILES_${PN}-jackd_append = " ${sysconfdir}/default/jackd "

do_install_append() {
        install -d ${D}${sysconfdir}/default
        echo "
logger 'Setup the Mic1 for input volume.'
amixer set Mic1 Playback 6
logger 'Setup the Mic1 Boost for line db levels input. You can now plug your guitar.'
amixer set 'Mic1 Boost' 1
logger 'Enable capture on Mic1. Without this command, no sample data are read.'
amixer set Mic1 cap
logger 'Setup the DAC for playback volume.'
amixer set DAC Playback 59
logger 'Setup the ADC Gain for capture volume.'
amixer set 'ADC Gain' Capture 7
logger 'Setup Lineout for playback volume.'
amixer set 'Line Out' Playback 28
logger 'Setup Line In for playback volume.'
amixer set 'Line In' Playback 4
logger 'Turn off Mic2 Boost.'
amixer set 'Mic2 Boost' 0
logger 'Turn off Mic2.'
amixer set Mic2 Playback 0

logger 'Resulting amixer configuration:'
amixer |logger

OPTIONS=\" -R -P70 -t2000 -d alsa -dhw:0 -p 256 -n 2 -r 48000 --shorts -i1 -o2 \"

" >> ${D}${sysconfdir}/default/jackd
}

