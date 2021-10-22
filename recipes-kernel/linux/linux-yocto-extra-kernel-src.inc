EXTRA_KERNEL_FILES ?= ""
EXTRA_KERNEL_SRC_URI ?= ""
EXTRA_KERNEL_FILES_prepend_bcm-2xxx-rpi4 = "${THISDIR}/linux-yocto:"
EXTRA_KERNEL_SRC_URI_append_bcm-2xxx-rpi4 = " \
    file://0001-Revert-Revert-mmc-sdhci-Mask-spurious-interrupts.patch \
"
FILESEXTRAPATHS_prepend_osv-wrlinux := "${EXTRA_KERNEL_FILES}:"
SRC_URI_append_osv-wrlinux = " ${EXTRA_KERNEL_SRC_URI}"
