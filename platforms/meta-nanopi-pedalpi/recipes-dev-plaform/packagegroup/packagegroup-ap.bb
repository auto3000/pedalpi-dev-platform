# Copyright (C) 2012 Freescale Semiconductor
# Copyright (C) 2014 John Weber
# Released under the MIT license (see COPYING.MIT for the terms)
# This file originates from https://github.com/johnweber/meta-wandboard-ap/blob/master/recipes-images/packagegroup/packagegroup-wandboard-ap.bb


DESCRIPTION = "AP Package Group"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

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
    iperf2 \
    lmbench \
"

