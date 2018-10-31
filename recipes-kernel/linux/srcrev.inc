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
SRCREV_machine_kb-v4.18-standard-arm-versatile-926ejs ?= "285677060e108d00ed786b5347d447807d94a963"
LINUX_VERSION_kb-v4.18-standard-arm-versatile-926ejs ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-base ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-base ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-beaglebone ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-beaglebone ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-edgerouter ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-edgerouter ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "3c4062c44ede4f0f4d2a2476fff5aa68e495fd6e"
LINUX_VERSION_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-intel ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-intel ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-intel-socfpga ?= "0052b3aa80f18e3834c253413420f1af4e5f13b0"
LINUX_VERSION_kb-v4.18-standard-intel-socfpga ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-intel-x86 ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-intel-x86 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-mti-malta32 ?= "cbfe1fd6157ff4a1497dad50164bd493cb680f17"
LINUX_VERSION_kb-v4.18-standard-mti-malta32 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-mti-malta64 ?= "090c1efbf5d1e9267f73eec102a53ea7b155d7c1"
LINUX_VERSION_kb-v4.18-standard-mti-malta64 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-preempt-rt-base ?= "d8ec0b5f12be6b7f95acac905d85c4660bebb0b5"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-base ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel ?= "3f57d66607a71bd6e5e43109ff055797c734847b"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel-x86 ?= "f0b2ab39218562c4738d9727c01887dd7ee4a0fb"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel-x86 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-qemuarm64 ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-qemuarm64 ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-qemuppc ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-qemuppc ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "fad657599d15977f1ecb5cdf1719526dacf5f529"
LINUX_VERSION_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-base ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-tiny-base ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-common-pc ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-tiny-common-pc ?= "4.18.14"
SRCREV_machine_kb-v4.18-standard-tiny-intel ?= "2ba9a28434f83c917ad3cfb8b4f7db6066c26a99"
LINUX_VERSION_kb-v4.18-standard-tiny-intel ?= "4.18.14"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_4.18 = "yocto-4.18-wr"
SRCREV_meta_4.18 = "124356db579295d3dc8128396278dead1df0e2b9"
LINUX_VERSION_4.18 = "4.18.14"
