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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "acc8b32c0da6e9e41f6ec0b6b8d690ff7a8c02be"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-base ?= "afe9186ee0ac156144e33bd492bacc6fdc5eaecb"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "b7422e99bfffbf935f904e3a58fb91094f628b39"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "79488e471a78db3a4e1d1de80da269c3798ae8c6"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "9de9354630b95d47c0798008ef9fdc3e25060994"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "cfc00c515161cc3dc0825c61faff013c0da85253"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "251121a0968dccbec5a571d48725065e0e9d0519"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "9174493435b482dd1a403a6bfb612bc5a46c79a6"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "b4994f9b96607292a66b8ef774e83b3118218d39"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "57d9e2a1e52adb3b852e84b6268b0b83ceb1c6a5"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "7c9e1b1b169ee1617b3955803f461c09f7a35ce1"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "889e4ff60ec6337b2999771fd3799e62487ca3b2"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "35ecc7d080950f9515c9c361cc4cbb48ac988823"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "c17b0f4a82a09a16ba494b2ed69583851b52861c"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "56b48a1b57f3512f42ceabcd7c97a37dc92c3cb9"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "5016c81dc58ebdaec185894f8fd4bb9571a0ca05"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "c69861b945f7d11c3cd38ebc235a478e091347b3"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "7a7e784d7324a03f0fba0f51df941aab95f4dd39"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "064bc200e1eb01e05d8446b9370bc81c8de5d773"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "17372f7b9e5a6ae98ee61ed8175dfe8333e9c39b"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "ba5384fa9b1b5b0e6b88ce37367a6409d082cfe4"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.29"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "fe504ace35a674646edc979949b9356488badc4d"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.29"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "2461c91f779f275975547996d944b2fce9ba50da"
LINUX_VERSION_5.2 = "5.2.29"
