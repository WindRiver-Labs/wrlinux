#
# Copyright (C) 2017 Wind River Systems, Inc.
#
require recipes-kernel/linux/linux-yocto_${PV}.bb

KERNEL_FEATURES += "\
 cfg/virtio.scc \
 features/kvm/qemu-kvm-enable.scc \
 features/netfilter/netfilter.scc \
 features/lxc/lxc-enable.scc \
 features/ovp/docker.scc \
 features/intel-dpdk/intel-dpdk.scc \
"

COMPATIBLE_HOST = "x86_64.*-linux"
