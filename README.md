[![CircleCI](https://circleci.com/gh/auto3000/pedalpi-dev-platform/tree/master.svg?style=shield&circle-token=7deebe538e0b303c63efefdd48d0318eb8268e8e)](https://circleci.com/gh/auto3000/pedalpi-dev-platform/tree/master)

This project is a limitless pedalboard for guitarists based on cheap single board computers like Raspberry PI 2/3, NanoPI Neo Air or simply your high-end computer running Linux.

### Table of Contents
1. [How to run PedalPII](#how-to-run-pedalpii)
2. [Supported hardware](#supported-hardware)
2. [Supported software](#supported-software)
3. [Alternatives to PedalPII](#alternatives-to-pedalpii)
4. [How to build from scratch](#how-to-build-from-scratch)


# How to run PedalPII
## Option 1: installation on single board computers (ex: Raspberry PI 2, 3 or NanoPI Neo Air)

1. Build a pedalpi pedalboard from materials
2. Flash a sdcard with one release downloaded from page [Releases](https://github.com/auto3000/pedalpi-dev-platform/releases)
```Shell
$ sudo dd if=pedalpi-dev-platform-XXX-sdimg of=/dev/YYY bs=4096  # XXX is your hardware type, ex: 'raspberrypi3' and YYY is your SD card, ie 'sdb'
```
3. Plug the SD card and power on the pedalboard, you can already select from a large list of predefined pedalboards
4. Optionally, compose new effects from WEB interface. You must plug ethernet cable on the device or join 'pedalpi' WiFi network. Then launch your browser to http://pedalpi

## Option 2: installation on x86-64 Linux machines (Ubuntu, Fedora, ...)

Prerequisites:
a. Install Docker software from your Linux distribution (example on Ubuntu, Debian: 'sudo apt-get install docker.io' on the console)
b. Close all sound applications on your machines to free-up the sound card.
c. User would be in UNIX groups 'audio' and 'docker' with 'sudo adduser

1. Download the latest release from page [Releases](https://github.com/auto3000/pedalpi-dev-platform/releases)
2. Configure Docker with pedalpii image:
```Shell
$ docker import pedalpi-dev-platform-qemux86-64-xxxxxxxxxxxxxx.rootfs.tar.bz2 pedalpii
```
3. Run PedalPII from command line:
```Shell
$ docker docker run --cap-add SYS_NICE --device /dev/snd -v /dev/log:/dev/log -p 80:80 -p 9000:9000 --rm -it pedalpii /init-pedalpii.sh
```
4. The graphical user interface is accessible with a browser at http://localhost:80 [see screenshot](mod-ui-screenshot.png).
5. Plug your guitar to 'Line' audio connector of the Linux machine.
6. Optionally, compose new pedalboards from WEB interface and launch your browser to http://localhost:80 or access http://localhost:9000 to set up new pedals effects.

Remarks:
 - On the console interface, type 'next' or 'previous' to switch between predetermined pedal effects. CTRL-C is quitting the PedalPII software.
 - Your laptop or Linux machine is (probably) not configured to run in 'real-time', you may hear audio glitches. You shall set up properly your environment to minimize or prefer the single board computer, [see real-time audio recommendations](https://wiki.archlinux.org/index.php/Professional_audio). Ultimately, you shall install a Linux kernel for low latency (`sudo apt-get install linux-image-lowlatency` in Ubuntu and a reboot do the trick)
 - ALSA is the default for PedalPII, since ALSA is the standard in Linux distributions, this should work for most people. The variable JACKD\_OPTIONS can be used to specify another sound layer [see jackd documentation](https://linux.die.net/man/1/jackd). For info, the default JACKD\_OPTIONS is defined as below:
```Shell
docker run -e JACKD_OPTIONS="-P70 -p256 -t2000 -d alsa -dhw:0,0 -p 256 -n 3 -r 48000 -s " --cap-add SYS_NICE --device /dev/snd -v /dev/log:/dev/log -p 80:80 -p 9000:9000 --rm -it  pedalpii /init-pedalpii.sh
```
 - If you need to specify two differents audio cards for guitar capture and audio output, you can override JACKD\_OPTIONS as below with parameters -C/-P respectively for capture/playback. In this example, a Ubisoft Rocksmith USB cable microphone is plugged for guitar capture, and internal audio card of the laptop is used for headphones.
```Shell
$ cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0x94320000 irq 322
 1 [Adapter        ]: USB-Audio - Rocksmith USB Guitar Adapter
                      Hercules Rocksmith USB Guitar Adapter at usb-0000:00:14.0-2, full speed

$ docker run -e JACKD_OPTIONS="-P70 -p256 -t2000 -d alsa -Phw:0 -Chw:1 -p 256 -n 3 -r 48000 -s "  --device /dev/snd -v /dev/log:/dev/log -p 80:80 -p 9000:9000 --rm -it  pedalpii /init-pedalpii.sh
```

# Supported hardware

The PedalPII comes into three flavors: (1) Raspberry PI 2 or 3, (2) NanoPI Neo Air, and (3) Docker image for X86-64.

1. The total cost for Raspberry PI flavor is targeted under 150\$. The main costs are the sound card (Prodipe Studio 22 USB is 80\$, Pisound audio board is 99\$), the Raspberry Pi 2/3 (40\$), and the Hammond 1590DD aluminium box (20\$). Remaining furnitures are under 10\$: 2GB SDcard, one 1602 LCD display, one MF-A04 bakelite knob, two 1/4 mono jack plug audio connector, two 1/4 jack socket connector female panel mount, and one 3PDT switch true bypass.
2. The total cost for this competitor is targeted under 60\$. The main cost is the NanoPi Neo Air (30\$) that includes a onboard eMMC storage and audio sound codec, and the Hammond 1590DD aluminium box (20\$). Remaining furnitures are under 10\$: one 1602 LCD display, one MF-A04 bakelite knob, two 1/4 mono jack plug audio connector, and one 3PDT switch true bypass.
3. The total cost is 0\$. You are already using a laptop with onboard audio sound cards. You may have to use jack adapters to plug your laptop to your guitar/amps, but you already got that, didn't you ?

PedalPII is multiplatform thanks to the Linux Yocto software architecture, and retarget to a new hardware platform must be easy. You can find a non-exhaustive (!) [list of +5000 supported hardware](http://layers.openembedded.org/layerindex/branch/master/machines/?q=&search=1). You may port this software to any variant of Orange PI, C.H.I.P., IMX8MQ, Tegra X1 or Odroid-XU4. To reach sufficient performance for any installed pedal effect, the minimal hardware requirement would be a dual core at 1GHz, 128MB of RAM and 1GB of flash. You may also want to remove some included development tools and shrink down to 400MB of flash.

# Supported software

This platform integrates a lot of LV2 plugins for effects, MOD suite and JACK for audio platform. The complete list is provided by [meta-pedalpi layer](https://github.com/auto3000/meta-pedalpi).

This software layer is built over the Yocto 'morty' release and additional support layers. Again, the list is too large but these layers provides the build system, python, ruby, QT5, and any runtime required to support LV2 plugins, MOD suite and JACK software.

This branch is based on the Yocto 'morty' release and you can find its latest version at [morty branch](https://github.com/auto3000/pedalpi-dev-platform/tree/morty).

For info on available baselines, please refer to [master branch](https://github.com/auto3000/pedalpi-dev-platform/tree/master) of this repository.

# Alternatives to PedalPII

I think PedalPII is one of the best pedal effect distribution, but of course I'm biased. There are many other good alternatives including:
1. [MOD Duo](https://www.moddevices.com/), is a good but a little pricey 700\$ pedalboard. This is not really a DIY pedalboard but one can add new effects and interfaces to this device.
2. [MOD DEP](https://blokas.io/), enables the 99\$ [Pisound audio board](https://blokas.io/store) for a 40\$ Raspberry PI 3. This pedalboard is based on MOD Duo software running over Armbian.
3. [POP](https://popularelectronics.technicacuriosa.com/2017/03/07/pop-the-programmable-open-pedal/) runs MOD Duo software on the the 9\$ C.H.I.P. board from Next Thing Co.
4. [Pedal-Pi](https://www.electrosmash.com/pedal-pi) is a lo-fi programmable guitar pedal that works with the 10\$ Raspberry Pi Zero Board and a custom MCP6002, MCP3202 and PWM-based audio board.
5. [PedalPI](https://github.com/PedalPi) is based on 40\$ Raspberry PI 3, a 3\$ USB audio card and the 10\$ Raspberry Pi Zero for physical buttons. This pedalboard is based on a combination lower software layers of MOD Duo for pedal effects and an enhanced user interface.
6. [Guitar Extended](https://guitarextended.wordpress.com/2013/01/31/raspberry-pi-multi-effects-overview-of-the-setup/) is based on 30\$ Raspberry PI, an Arduino Uno for physical buttons, 100\$ E-MU 0404 audio card, and [Pure Data](http://puredata.info/) for software pedal effects.
7. [Arnout's pedal](http://arre234.blogspot.com/2018/02/linux-portable-wifi-guitar-amp-on.html) is based on 7\$ Orange PI Zero, a 3\$ USB audio card. The software is relying on [Guitarix](http://guitarix.org/).
8. I shall mention my undisclosed prior project 'PedalPI', based on a modified [Rakarrack](http://rakarrack.sourceforge.net/) software suite running 40\$ Rasperry PI 2 and 80\$ USB audio card [see history](https://github.com/auto3000/pedalpii)

Please let me know if this list is missing your project. Note: there are numerous projects related to DIY synth or DIY amps: the software may be the same as DIY guitar pedalboards.

# How to build from scratch
pedalpi development platform integrates pedalpi software components developed into a release that can be downloaded and run on popular hardware development boards.

Please see the README in [meta-pedalpi](https://github.com/auto3000/meta-pedalpi/) and [PedalPI v2](https://github.com/auto3000/pedalpii) for further information.

## pedalpi-dev-platform.git usage
This project uses submodules to pull in layer dependencies. It is advised to avoid using the --recursive option for the initial clone. 'master' is the default branch. Previous release 'maintenance' branches are also available. Note certain tags may require a different set of usage instructions, please refer to the relative README.
```Shell
$ git clone https://github.com/auto3000/pedalpi-dev-platform
```
To initiate the build environment:
```Shell
$ source init.sh (raspberrypi2|raspberrypi3|nanopi-neo-air|qemux86-64)
```
Currently this requires the use of the bash shell.

The `init.sh` script handles the target specific bitbake configuration. The target templates can be found in pedalpi-src-build/conf/templates, as well as common configuration `.inc` files. `init.sh` also handles the relevant git submodule initiation.

To build:
```Shell
$ bitbake pedalpi-dev-platform
```
The resulting sdcard image would appear in `tmp/deploy/images/`.

## Flash and run PedalPI on NanoPi Neo Air on SD card
Type these commands:
```Shell
$ git clone https://github.com/auto3000/pedalpi-dev-platform
$ cd pedalpi-dev-platform
$ source init.sh nanopi-neo-air
$ bitbake pedalpi-dev-platform
$ sudo dd if=tmp/deploy/images/nanopi-neo-air/pedalpi-dev-platform-nanopi-neo-air.sunxi-sdimg of=/dev/sdXXX bs=4096  # XXX is your SD card
```
Plug the SD card in your NanoPi Neo Air and power on the device.
The `pedalpi` WiFi network is open (no password) and allow you to access the MOD-UI user interface [see screenshot](mod-ui-screenshot.png)  at address [http://10.10.10.1](http://10.10.10.1).

## Flash and run PedalPI on RaspberryPI 2 on SD card
Type these commands:
```Shell
$ git clone https://github.com/auto3000/pedalpi-dev-platform
$ cd pedalpi-dev-platform
$ source init.sh raspberrypi2
$ bitbake pedalpi-dev-platform
$ sudo dd if=tmp/deploy/images/nanopi-neo-air/pedalpi-dev-platform-raspberrypi2.sdimg of=/dev/sdXXX bs=4096  # XXX is your SD card
```
Plug the SD card in your RaspberryPI 2 and power on the device.
The Raspberry PI 2 connects automatically on ethernet network with DHCP. You may connect to the MOD-UI user interface [see screenshot](mod-ui-screenshot.png) at address [http://pedalpi](http://pedalpi) or the dynamically allocated IP address.

## Flash and run PedalPI on RaspberryPI 3 on SD card

Follow the procedure for the RaspberryPI 2, but replace 'raspberrypi2' by 'raspberrypi3' during procedure execution.

## Run PedalPI on QEMU

Type these commands:
```Shell
$ git clone https://github.com/auto3000/pedalpi-dev-platform
$ cd pedalpi-dev-platform
$ source init.sh qemux86-64
$ bitbake pedalpi-dev-platform
$ runqemu qemux86-64 serial audio
```
A virtual IP address is allocated to the QEMU session, you can connect to the port 80 at this address in your browser to access to the MOD-UI user interface [see screenshot](mod-ui-screenshot.png).
