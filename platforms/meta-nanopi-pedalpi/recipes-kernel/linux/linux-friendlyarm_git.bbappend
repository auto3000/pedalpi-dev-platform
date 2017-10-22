FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://disable_ads7846.cfg \
	file://enable_preempt.cfg \
	file://0001-sun4i-codec-configure-DMA-layer-for-lower-latency.patch \
	"
