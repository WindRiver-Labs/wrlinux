#
# This file is generated based on:
#     linux-yocto-5.2
#     yocto-kernel-cache
#
# Any manual changes will be overwritten.
#

# linux-yocto-5.2 entries
# This will cause SRCREV_machine_kb-<KBRANCH> take priority over SRCREV_machine_<machine>
MACHINEOVERRIDES .= ":kb-${@d.getVar('KBRANCH', True).replace("/", "-")}"

# linux-yocto-5.2 branch entries
SRCREV_machine_kb-master ?= "ef283bb23883069e248fca8b4099c7dab9ddc8b6"
LINUX_VERSION_kb-master ?= "5.2.17"
SRCREV_machine_kb-v5.2-upstream ?= "5e408889e4af03a27b77cf4635934fefb9f4afab"
LINUX_VERSION_kb-v5.2-upstream ?= "5.2.17"
SRCREV_machine_kb-v5.2-base ?= "e9b75c60f91a359cb0e1b2d0a9ed1c81485215e2"
LINUX_VERSION_kb-v5.2-base ?= "5.2.2"
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "c804676c599598a659e3c1554fa7921d34054b82"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-base ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "bdfd0dd788f689632bb5344c61751e004db9af91"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "1505c28a9260e38d9d9c69ff86a0f29e36482007"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "f77383efbe4525c66a84b834297d3a133c59b132"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "53eab83fc198b3ea20f2cbe14c232e104dd9a234"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "50caf4bf971ab1dea8b882fb983de51784aa90e7"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "c14ae4269ee8308fd0ba32ddaf8b87bd58acf9af"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "132d3afe13f3d45cf118a652a2d95d44603759a2"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "b7523b8cce01b9f260e17f0e75c69c1978d56eae"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "af15c0d430ee44300bfb5eaf2eabc028cd09fa57"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "3f4d9de5870919c64fece92eeee73f11809d2514"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "370ab92a1eaf673bae8766943cf6700c083bcaae"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "a3f7a8998fc37bf24b19be3b066dfcbf1c3df87e"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.24"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "506798ce18ec418291862886c8ff49c27979114e"
LINUX_VERSION_5.2 = "5.2.24"
