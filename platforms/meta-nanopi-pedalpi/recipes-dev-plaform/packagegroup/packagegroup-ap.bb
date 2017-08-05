# Copyright (C) 2012 Freescale Semiconductor
# Copyright (C) 2014 John Weber
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "AP Package Group"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES += " \
    ${PN}-base \
    ${PN}-test \
"

RDEPENDS_${PN}-base = " \
    wpa-supplicant \
    hostapd \
    dhcp-server \
    dhcp-server-config \
"

RDEPENDS_${PN}-test = " \
    ${PN}-base \
    dropbear \
    openssh-sftp-server \
    iperf \
    lmbench \
"

