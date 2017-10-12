#
# Copyright (C) 2017 Wind River Systems, Inc.
#

KBRANCH ?= "standard/preempt-rt/base"

require recipes-kernel/linux/linux-yocto.inc

SRCREV_machine ?= "16de0149674ed12d983b77a453852ac2e64584b4"
SRCREV_meta ?= "eda4d18ce4b259c84ccd5c249c3dc5958c16928c"

SRC_URI = "git://git.yoctoproject.org/linux-yocto-4.12.git;branch=${KBRANCH};name=machine \
           git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=yocto-4.12;destsuffix=${KMETA}"

LINUX_VERSION ?= "4.12.12"

PV = "${LINUX_VERSION}+git${SRCPV}"

KMETA = "kernel-meta"
KCONF_BSP_AUDIT_LEVEL = "2"

LINUX_KERNEL_TYPE = "preempt-rt"

COMPATIBLE_MACHINE = "(qemux86|qemux86-64|qemuarm|qemuppc|qemumips)"

KERNEL_DEVICETREE_qemuarm = "versatile-pb.dtb"

# Functionality flags
KERNEL_EXTRA_FEATURES ?= "features/netfilter/netfilter.scc features/taskstats/taskstats.scc"
KERNEL_FEATURES_append = " ${KERNEL_EXTRA_FEATURES}"
KERNEL_FEATURES_append_qemuall=" cfg/virtio.scc"
KERNEL_FEATURES_append_qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
KERNEL_FEATURES_append_qemux86-64=" cfg/sound.scc"

# OVP specific config

KERNEL_FEATURES_append += "\
 features/intel-dpdk/intel-dpdk.scc \
"

COMPATIBLE_HOST = "(i.86|x86_64).*-linux"

require recipes-kernel/linux/linux-yocto_virtualization.inc
