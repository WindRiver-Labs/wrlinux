RPIADDITIONAL_KERNEL_FILES ?= ""
RPIADDITIONAL_KERNEL_SRC_URI ?= ""
RPIADDITIONAL_KERNEL_FILES_bcm-2xxx-rpi4 = "${THISDIR}/linux-yocto:"
RPIADDITIONAL_KERNEL_SRC_URI_bcm-2xxx-rpi4 = " \
    file://0001-dwc_otg-Declare-DMA-capability-with-HCD_DMA-flag.patch \
    file://0002-dwc_otg-checking-the-urb-transfer_buffer-too-early-3.patch \
    file://0003-dwc_otg-constrain-endpoint-max-packet-and-transfer-s.patch \
    file://0004-dwc_otg-fiq_fsm-add-a-barrier-on-entry-into-FIQ-hand.patch \
    file://0001-vc4-fkms-v3d-overlay.dts-Add-hdmi.patch \
"
EXTRA_KERNEL_SRC_URI += "${RPIADDITIONAL_KERNEL_SRC_URI}"
EXTRA_KERNEL_FILES =. "${RPIADDITIONAL_KERNEL_FILES}"

FILESEXTRAPATHS_prepend_osv-wrlinux := "${EXTRA_KERNEL_FILES}:"
SRC_URI_append_osv-wrlinux = " ${EXTRA_KERNEL_SRC_URI}"
