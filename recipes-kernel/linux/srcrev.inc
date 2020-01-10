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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "c6c750c16ed69df64e7797eda86a762c4645ec6b"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-base ?= "3a29fe3284cee75100c17ef9ec2d8aaad8aa732c"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "edf8202759721443f2b438506137f0bd03f5d7bc"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "5d2647b3e0507a3b7890c58ed036428066a4cae8"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "e501d0bde7f8764ea26ef53e98359f7dbdefe8f8"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "89d552c6806c655ec1d01b605b055aeea2425b4c"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "fe9643dafb7bffa21707fcaf6066a368e346d736"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "fcff8f6eadc5239d78a8758a9450a4361cd2b77c"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "4511a179e2179a56c62553488adb358b67223e6e"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "6bce229903208b5d91393d6420ab6966fd0c1ab2"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "a4172e0d14a42ff8ebef570f7fd0e12c3a7d88f5"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "87d98dc4116139d2cfcacd59356a0a51a4de67a1"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "7b66cadca9242643009438428f9969b432d07880"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "eb52cf59bce709f11a0dc23fb8da1b7ea00d5054"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "98ee489b22424d568354c85fcc59754668fb6945"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "895e24dfc1ccdae7e28168378bfb0e6fe81746d1"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "9f9d6874b4304b1b7824dd8549be2555563e2ce8"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "3cf43ea9d56b29e5eed77c1b19e6e7b5d7eb1025"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "a3cc1b45617d3f5884a8123ec14895aabfba5ba3"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "0b5e06ad7f41afaf2d0ff166a5ccab1104241504"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.28"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "a50900c8655f36b81b088241646ef543b9dccaed"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "2e01e03796c25f941fc3b6ee4e9f57478cee7eae"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.28"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "06a4bac8342d209c3c6e64e7a2ee2a55c657b5cc"
LINUX_VERSION_5.2 = "5.2.28"
