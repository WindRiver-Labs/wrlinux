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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "d0a10775d1cd3254de5fd7ab0616038e64e883f3"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-base ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "89c697e38b5aea4eb7f7b1a8bae5c14cd7af707b"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "5561ed1e4b20b52ae62394688605249046e744ed"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5562f2177da79150d54b16a2554652a877783db6"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "53eab83fc198b3ea20f2cbe14c232e104dd9a234"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "7b10c4f80e33bf4a5aa1f27e4d33220a5bf4634a"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "c19324f7c3cc384a3bdc3e78b95d25528a734578"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "e2077caf7f145e8f8ab98ff39d520e9215692542"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "49348b9b89da2e6fca267a8f8076e0fa3c043d4c"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "c93e118aa57add3ea468c964266f989599cbf3aa"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "95d588ef6f8c1cf5d3478bb60e96e449fa395a73"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "34462d734888f02c88f2fb686d74f42903c5992e"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.25"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "f169945255950ad4992a1baeb88cf1af225c0c7a"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.25"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "c0d42af39467b90c0b06b863cc27109955ad560f"
LINUX_VERSION_5.2 = "5.2.25"
