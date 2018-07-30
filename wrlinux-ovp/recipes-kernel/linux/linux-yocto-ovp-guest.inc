#
# Copyright (C) 2017 Wind River Systems, Inc.
#

# meta-virtualization does not have a bbappend for linux-yocto-rt
require ${@bb.utils.contains('DISTRO_FEATURES', 'virtualization', 'recipes-kernel/linux/linux-yocto_virtualization.inc', '', d)}

KERNEL_FEATURES += "\
 features/intel-dpdk/intel-dpdk.scc \
"

# Only qemux86 and qemux86-64 is allowed!
TARGET_SUPPORTED_KTYPES_qemux86 = "preempt-rt"
TARGET_SUPPORTED_KTYPES_qemux86-64 = "preempt-rt"

# Most BSPs provide a compatible_machine override, the distro override
# has a higher priority then machine override so use it to block other
# BSPs.
COMPATIBLE_MACHINE_wrlinux-ovp = "(qemux86|qemux86-64)"

COMPATIBLE_HOST = "(i.86|x86_64).*-linux"

SRCREV_machine = "${AUTOREV}"
SRCREV_meta = "${AUTOREV}"
