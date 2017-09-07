#
# Copyright (C) 2017 Wind River Systems, Inc.
#
require recipes-kernel/linux/linux-yocto-rt_${PV}.bb

KERNEL_FEATURES_append += "\
 cfg/virtio.scc \
 features/intel-dpdk/intel-dpdk.scc \
"

COMPATIBLE_HOST = "(i.86|x86_64).*-linux"
