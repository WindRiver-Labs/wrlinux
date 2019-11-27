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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "eae79a47742a27b57895dfc31033940078a58591"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-base ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "844785562feff9dd3f7b617c555efdf9b6ff931e"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "741625d20115b08439a37670ae6f6bc93b78a374"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "3b74062b59c3f63a814db6040870f887ff0caad9"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "53eab83fc198b3ea20f2cbe14c232e104dd9a234"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "f5039ff845ae347063e6880d89d2e60f879ff856"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "1c863c05958faf522455713270317a4647e27578"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "2761299685e59f4838784b9764f22f31c0ba78cc"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "84b518440d7cef4b8ade82b716f9aa9da61f098a"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "b96788fab228f31ca33f804317b252590b94c484"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "fdfb41a859911607f9be6719615365e222c41c5c"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "eb4da2e1ea7630f969e6dc25a1dc96eaeab1b6ec"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.24"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "c345e05bae60f140efecc66a2e5649d27ea8b0fb"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.24"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "6ab085fa21c9da7d59c979d89a391f622b0e7530"
LINUX_VERSION_5.2 = "5.2.24"
