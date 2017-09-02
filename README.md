# pedalpi development platform
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
The `pedalpi` WiFi network is open (no password) and allow you to access the MOD-UI user interface [see screenshot](http://blog.moddevices.com/wp-content/uploads/2017/07/screen-shot-2017-06-29-at-18.04.25-fullpage.png)  at address [http://10.10.10.1](http://10.10.10.1).

## Flash and run PedalPI on RaspberryPI 2 on SD card
Type these commands:
```Shell
$ git clone https://github.com/auto3000/pedalpi-dev-platform 
$ cd pedalpi-dev-platform
$ source init.sh raspberrypi2
$ bitbake pedalpi-dev-platform
$ sudo dd if=tmp/deploy/images/nanopi-neo-air/pedalpi-dev-platform-nanopi-neo-air.sdimg of=/dev/sdXXX bs=4096  # XXX is your SD card
```
Plug the SD card in your RaspberryPI 2 and power on the device. 
The Raspberry PI 2 connects automatically on ethernet network with DHCP. You may connect to the MOD-UI user interface [see screenshot](http://blog.moddevices.com/wp-content/uploads/2017/07/screen-shot-2017-06-29-at-18.04.25-fullpage.png)  at address [http://pedalpi](http://pedalpi) or the dynamically allocated IP address.

## Flash and run PedalPI on RaspberryPI 3 on SD card

Follow the procedure for the RaspberryPI 2. 

## Run PedalPI on QEMU

Type these commands:
```Shell
$ git clone https://github.com/auto3000/pedalpi-dev-platform 
$ cd pedalpi-dev-platform
$ source init.sh qemux86-64
$ bitbake pedalpi-dev-platform
$ runqemu qemux86-64 serial audio
```
A virtual IP address is allocated to the QEMU session, you can connect to the port 80 at this address in your browser to access to the MOD-UI user interface [see screenshot](http://blog.moddevices.com/wp-content/uploads/2017/07/screen-shot-2017-06-29-at-18.04.25-fullpage.png).



