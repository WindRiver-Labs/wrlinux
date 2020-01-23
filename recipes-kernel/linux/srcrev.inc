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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "84bf15a832901843ed9d605695e88058d010efa2"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-base ?= "958e2e48842d3049d302a38e857eecbcc2b1548f"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "6702e5c4b972b974c81b9ede13983b60506453ca"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "64ff2054a6e0925237759b33a6cf45c313a192dc"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "0b22dedbfdb5428b75cf3df036cd3e36913da079"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "5603db450ec758c1f9f6f60b56de9bdb449f115c"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "f66ea3a486dc9a5d35e00ad9020e80aacca1cc77"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "59995c361a25f0c77ff6d06de5dfe5821779aa1b"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "b8ac05214aca263f39dcfed89594e8c5343f774b"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "d3a7e6f95284c96f76bd61d01d9b0974e90de328"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "4395d7a9dd045e9aee344ca0a5c63f6fa46586f1"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "c461fd9234c823c0601d63a793ac96f1414e7bde"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "48baa059b4b48ce61a397b85adb439227409c909"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "0bf94c7c88b239cb8352eb37962dc0fcc184c187"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "3623e45806d87a1b3356a6a7d13c9eb3f1adef30"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "9f097b41b25f3e50f0dab3d3a348c0639461646c"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "451eb05e60531f3393e7a18994498cb4b64ff324"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "6843c619949a7f5720b1ea0fd9100827d04ee7a5"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "b2199f3812f83c2e26a0bb6c7f660ea75e929aee"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "6401202a7c8fba1b6ba9c0f6876b136d2bca9cf0"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "0d310bb5e95c9e97fc3984e95dc1cc7fd7663ccc"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.30"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "6ef6bc78deda0b7cfd22069be58dda0933a7eee4"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.30"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "f9ab1871e31b6665c7b43154eea1b1bfb8aef585"
LINUX_VERSION_5.2 = "5.2.30"
