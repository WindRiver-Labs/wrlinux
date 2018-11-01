#
# Copyright (C) 2017 Wind River Systems, Inc.
#

# meta-virtualization does not have a bbappend for linux-yocto-rt
require ${@bb.utils.contains('DISTRO_FEATURES', 'virtualization', 'recipes-kernel/linux/linux-yocto_virtualization.inc', '', d)}

KERNEL_FEATURES += "\
 cfg/virtio.scc \
 cfg/rbd.scc \
 features/netfilter/netfilter.scc \
 features/lxc/lxc-enable.scc \
 features/intel-dpdk/intel-dpdk.scc \
 features/aufs/aufs-enable.scc \
 features/nfsd/nfsd-enable.scc \
 features/vfio/vfio.scc \
 features/xfs/xfs.scc \
"

COMPATIBLE_HOST = "x86_64.*-linux"
