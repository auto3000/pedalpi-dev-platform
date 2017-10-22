FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://disable_ads7846.cfg \
	file://enable_preempt.cfg \
	"
