#!/bin/sh

echo "This script must have been launched with something like 'docker run --device /dev/snd -v /dev/log:/dev/log -p 80:80 --rm -it your_pedalpi_image /init-pedalpii.sh'"

if [ "$JACKD_OPTIONS"x != ""x ]
then
	echo JACKD_OPTIONS variable is detected
	echo OPTIONS=\"$JACKD_OPTIONS\" >> /etc/default/jackd
fi

# Launch JACK and MOD sound system
/etc/init.d/jackd start
sleep 1

/etc/init.d/mod-host start
sleep 1

/etc/init.d/mod-ui start
sleep 1

if [ -f /etc/init.d/mod-sdk ]; then 
    /etc/init.d/mod-sdk start
    sleep 1
fi

# Launch PedalPII user interface
echo "To quit, press CTRL-C to quit on PedalPII console"
pedalpII

test -f /etc/init.d/mod-sdk && /etc/init.d/mod-sdk stop
/etc/init.d/mod-ui stop
/etc/init.d/mod-host stop
/etc/init.d/jackd stop

exit 0
