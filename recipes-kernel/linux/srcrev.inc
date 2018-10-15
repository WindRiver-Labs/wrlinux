#
# This file is generated based on:
#     linux-yocto-4.18
#     yocto-kernel-cache
#
# Any manual changes will be overwritten.
#

# linux-yocto-4.18 entries
# This will cause SRCREV_machine_kb-<KBRANCH> take priority over SRCREV_machine_<machine>
MACHINEOVERRIDES .= ":kb-${@d.getVar('KBRANCH', True).replace("/", "-")}"

# linux-yocto-4.18 branch entries
SRCREV_machine_kb-master ?= "8a8c540db3ff1968317759961c0230221882367d"
LINUX_VERSION_kb-master ?= "4.18.3"
SRCREV_machine_kb-v4.18-base ?= "8a8c540db3ff1968317759961c0230221882367d"
LINUX_VERSION_kb-v4.18-base ?= "4.18.3"
SRCREV_machine_kb-v4.18-standard-arm-versatile-926ejs ?= "ef0043f38afb743bffdc39aacc54ea2419da0be3"
LINUX_VERSION_kb-v4.18-standard-arm-versatile-926ejs ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-base ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-base ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-beaglebone ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-beaglebone ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-edgerouter ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-edgerouter ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "20be2231bb047b02248d7f965c1c3af0c6be3a5e"
LINUX_VERSION_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-intel ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-intel ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-intel-x86 ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-intel-x86 ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-mti-malta32 ?= "a6d4477ea91aec9d3d6af538f8f9d27a687540aa"
LINUX_VERSION_kb-v4.18-standard-mti-malta32 ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-mti-malta64 ?= "766c469b1707fd3101116f572052a7b8d5ac0658"
LINUX_VERSION_kb-v4.18-standard-mti-malta64 ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-preempt-rt-base ?= "4eb8994d5c8556fe917d851d678f7db8cfc30c77"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-base ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel ?= "748c11acb0e0b84f3dbd5361fcb5246c8e27bb0b"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel-x86 ?= "ef0164a501c18b0f8b1653ea18ef73977c765939"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel-x86 ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-qemuarm64 ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-qemuarm64 ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-qemuppc ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-qemuppc ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "cce6bd36d803f4e7dad90f0d5a4a55c6c2ec2a25"
LINUX_VERSION_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-tiny-base ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-tiny-base ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-tiny-common-pc ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-tiny-common-pc ?= "4.18.9"
SRCREV_machine_kb-v4.18-standard-tiny-intel ?= "0cdc8564c61958a39704d97e008120bd7c762f60"
LINUX_VERSION_kb-v4.18-standard-tiny-intel ?= "4.18.9"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_4.18 = "yocto-4.18-wr"
SRCREV_meta_4.18 = "248eaf587310b1887449dc2c6129d5e3065796c6"
LINUX_VERSION_4.18 = "4.18.9"
