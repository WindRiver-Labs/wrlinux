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
SRCREV_machine_kb-v4.18-base ?= "8a8c540db3ff1968317759961c0230221882367d"
LINUX_VERSION_kb-v4.18-base ?= "4.18.3"
SRCREV_machine_kb-v4.18-standard-arm-versatile-926ejs ?= "0ccc3a1c4ac6ad712be41e83a08a01de7ea8f3f8"
LINUX_VERSION_kb-v4.18-standard-arm-versatile-926ejs ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-base ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-base ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-beaglebone ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-beaglebone ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-edgerouter ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-edgerouter ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "15ee6fb3ddd34064fea7c3f5e635ecb8d6a974bf"
LINUX_VERSION_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-intel ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-intel ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-intel-socfpga ?= "09b9ff9ca0521e3dc1987ec9b79635ce24370446"
LINUX_VERSION_kb-v4.18-standard-intel-socfpga ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-intel-x86 ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-intel-x86 ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-mti-malta32 ?= "e5c2b57fb8dfaae90014f4ec07689c97f634cbcf"
LINUX_VERSION_kb-v4.18-standard-mti-malta32 ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-mti-malta64 ?= "b60ebfc39bee8da6acff4e8add4af6045d1843f2"
LINUX_VERSION_kb-v4.18-standard-mti-malta64 ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-preempt-rt-base ?= "96664e80434995740b129f9dc5643e23b440db82"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-base ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel ?= "f1ab03a28806af68e66ef5aaf6ebc79dff1f51d8"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel-x86 ?= "4edccef8083184d0fd2aff237a9d7f1ed00b71d8"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel-x86 ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-preempt-rt-xilinx-sdk2018-03-xilinx-zynqmp ?= "c7d49925695daa5cefd6f8f86159b3b308874b14"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-xilinx-sdk2018-03-xilinx-zynqmp ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-qemuarm64 ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-qemuarm64 ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-qemuppc ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-qemuppc ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-ti-am335x ?= "ed181035b30bc2022c44ec35efb4fa2f0677707e"
LINUX_VERSION_kb-v4.18-standard-ti-am335x ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "aee695377bdc1f8779a2c68383c069a664cbdf85"
LINUX_VERSION_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-tiny-base ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-tiny-base ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-tiny-common-pc ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-tiny-common-pc ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-tiny-intel ?= "3ec998a9e3e48f7f01c698c3932333be1c1f13df"
LINUX_VERSION_kb-v4.18-standard-tiny-intel ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-wr-base ?= "48af9a3745322cabf958f819e9953d4958dcc3ae"
LINUX_VERSION_kb-v4.18-standard-wr-base ?= "4.18.20"
SRCREV_machine_kb-v4.18-standard-xilinx-sdk2018-03-xilinx-zynqmp ?= "9633fac7ba36c722b74bda36731b2cf4eb8a2681"
LINUX_VERSION_kb-v4.18-standard-xilinx-sdk2018-03-xilinx-zynqmp ?= "4.18.20"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_4.18 = "yocto-4.18-wr"
SRCREV_meta_4.18 = "2f13ff41162ec0663c4c2caa973a1fd8cad71e0a"
LINUX_VERSION_4.18 = "4.18.20"
