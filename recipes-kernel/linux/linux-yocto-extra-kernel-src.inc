EXTRA_KERNEL_FILES ?= ""
EXTRA_KERNEL_SRC_URI ?= ""
EXTRA_KERNEL_FILES_prepend_bcm-2xxx-rpi4 = "${THISDIR}/linux-yocto:"
EXTRA_KERNEL_SRC_URI_append_bcm-2xxx-rpi4 = " \
    file://0001-Revert-Revert-mmc-sdhci-Mask-spurious-interrupts.patch \
"
EXTRA_KERNEL_FILES_prepend_aarch64 = "${THISDIR}/linux-yocto:"
EXTRA_KERNEL_SRC_URI_append_aarch64 = " \
    file://0001-iommu-arm-smmu-v3-Ratelimit-event-dump.patch \
"
EXTRA_KERNEL_FILES_prepend_marvell-cn106xx = "${THISDIR}/linux-yocto:"
EXTRA_KERNEL_SRC_URI_remove_marvell-cn106xx = " \
    file://0001-iommu-arm-smmu-v3-Ratelimit-event-dump.patch \
"
EXTRA_KERNEL_SRC_URI_append_marvell-cn106xx = " \
    file://0001-iommu-arm-smmu-v3-Ratelimit-event-dump-for-marvell-cn106xx.patch \
"
FILESEXTRAPATHS_prepend_osv-wrlinux := "${EXTRA_KERNEL_FILES}:"
SRC_URI_append_osv-wrlinux = " ${EXTRA_KERNEL_SRC_URI}"
