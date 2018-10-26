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
SRCREV_machine_kb-v4.18-standard-arm-versatile-926ejs ?= "0573ed3c737c82b24fd661cc5ea961cac07ea2fe"
LINUX_VERSION_kb-v4.18-standard-arm-versatile-926ejs ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-base ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-base ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-beaglebone ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-beaglebone ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-edgerouter ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-edgerouter ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "745a60b007b2d288098587bcb7b0f87dfddddef1"
LINUX_VERSION_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-intel ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-intel ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-intel-socfpga ?= "9663d6f1ea00f357cca74cc4685eab80b69f2378"
LINUX_VERSION_kb-v4.18-standard-intel-socfpga ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-intel-x86 ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-intel-x86 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-mti-malta32 ?= "465252ba0ec00ae10397cb4623c3d77c89e542a5"
LINUX_VERSION_kb-v4.18-standard-mti-malta32 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-mti-malta64 ?= "6d91dc62811f4688efc67845185858645b4ccfb8"
LINUX_VERSION_kb-v4.18-standard-mti-malta64 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-preempt-rt-base ?= "8e00c30ce22f378ecb7f243b1df3d209b8ee29bc"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-base ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel ?= "a07a91353d222125fc9e501ad082e00a3d71a00e"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel-x86 ?= "67b4c21e276d8523fbb55b53dab8248ce638c085"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel-x86 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-qemuarm64 ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-qemuarm64 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-qemuppc ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-qemuppc ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "cdc9b78dd8cc1da23976b889299fdc94bb17a8bb"
LINUX_VERSION_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-base ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-tiny-base ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-common-pc ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-tiny-common-pc ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-intel ?= "33859b3077c83d8a024946ba06a59990546fcbc7"
LINUX_VERSION_kb-v4.18-standard-tiny-intel ?= "4.18.14"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_4.18 = "yocto-4.18-wr"
SRCREV_meta_4.18 = "124356db579295d3dc8128396278dead1df0e2b9"
LINUX_VERSION_4.18 = "4.18.14"
