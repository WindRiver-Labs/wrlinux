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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "2b9e601e0d1b77fc8e6e5a9bd46551bfac9af04f"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-base ?= "afe9186ee0ac156144e33bd492bacc6fdc5eaecb"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "6cdcc03679290d5a572a8b99f34476a2f0f7ad4c"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "28294be2d404188376634158a1b86d40ba21c469"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "cf96a73357b51c6c1ae25db5fa7933a7976930ca"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "ded0bc9beaf924fa9337f6154a2b8471a5c86fcb"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "e0e61b8300986a923dc379ed83714b5c0a36f5de"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "3e448c8b6dabf0cba3028a6177e0d7b6168090d6"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "b1a9faa2674075ac0ca1ed6273fdb074e7244cb4"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "bdfcd6d87d957aaa37e76639cb212c046be03270"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "c495a380a077af86dc1332b0ffedd8e6d8f90a25"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "0c7ea1e523fb7ec3c26f5203413602060583ca42"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "7afad8c13e6f1675b6d7cc01f14db8f99cb0e846"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "ddd0e25329bde31810f72551d3347989ef2e6c71"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "7dc471c79838817b39be7007ed3461e8d2e47010"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "4a84c31d2662d9541f4f890b6cb6d854cfb1ef3d"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5aa4df5d6e43eec286f2aa781faad0b2f761e8c4"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "2166cc86352df781b6ac88e3b6e7651ee89730a6"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "a6eccf2dd9072b8127e0a38e7e258580f69ac6e0"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "c4c2eb6e83492b39b4b1b39c9c48ef618c56aac0"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "428185baa024b05c173ad319d2e6353ed3cc30ed"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "5b538a45d7401e9176463fd07030686be0d4a422"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.29"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "503462f39f4c858d56fd6d6a390995966abdf151"
LINUX_VERSION_5.2 = "5.2.29"
