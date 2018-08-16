require linux-yocto-wrlinux.inc
include srcrev.inc
require extra-kernel-src.inc

TARGET_SUPPORTED_KTYPES_append_qemuall = " preempt-rt"
