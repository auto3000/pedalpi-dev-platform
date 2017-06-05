# pedalpi development platform
pedalpi development platform integrates pedalpi software components developed into a release that can be downloaded and run on popular hardware development boards.


pedalpi-dev-platform.git usage
------------------------------------
This project uses submodules to pull in layer dependencies.
It is advised to avoid using the --recursive option for the
initial clone. 'master' is the default branch. Previous release
'maintenance' branches are also available. Note certain tags
may require a different set of usage instructions, please refer
to the relative README.

    git clone <thisrepo> -b <branch>

To initiate the build environment:

    source init.sh $target

The current supported targets are raspberrypi2, raspberrypi3.
Currently this requires the use of the bash shell

The `init.sh` script handles the `$target` specific bitbake configuration.
The `$target` templates can be found in pedalpi-src-build/templates, as well as common
configuration `.inc` files. `init.sh` also handles the relevant git submodule
initiation.

To build:

    bitbake pedalpi-dev-platform

Please see the README in meta-pedalpi for further information.
