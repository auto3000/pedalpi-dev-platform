SUMMARY = "Extremely basic PedalPII init script, mainly for Docker usage"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
SRC_URI = "file://init-pedalpii.sh"

S = "${WORKDIR}"

DEPENDS = " mod-ui \
			mod-host \
			pedalpii "


do_install() {
        install -m 0755 ${WORKDIR}/init-pedalpii.sh ${D}/init-pedalpii.sh
}

inherit allarch

FILES_${PN} += " /init-pedalpii.sh "
