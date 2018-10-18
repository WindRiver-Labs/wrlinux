require linux-yocto-wrlinux.inc
include srcrev.inc
require extra-kernel-src.inc

TARGET_SUPPORTED_KTYPES_append_qemuall = " preempt-rt"

# qemuarma9 doesn't support preempt-rt.
TARGET_SUPPORTED_KTYPES_remove_qemuarma9 = "preempt-rt"
