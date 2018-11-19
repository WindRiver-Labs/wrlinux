require linux-yocto-wrlinux.inc
include srcrev.inc
require extra-kernel-src.inc

TARGET_SUPPORTED_KTYPES_append_qemuall = " preempt-rt"

# qemuarma9 doesn't support preempt-rt.
TARGET_SUPPORTED_KTYPES_remove_qemuarma9 = "preempt-rt"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI_append = " file://0001-scripts-Print-more-info-for-debugging-gcc-goto-error.patch"
