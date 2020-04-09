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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "a9fd95e01584ddf1eadb30138f554258e345cf80"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-base ?= "4aad64bc72c1c9bcf894c9849b980ddad8af26b7"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "3e1683e6db87968540c648cca91175b86c616807"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "9473e5f66062d767ffe4f21a4b27d02988747edd"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "1ec16f805a35b6def9ec59744369ef9ff132018c"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "b99582e3731b8ae1563550fbffe9cd74633b1851"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "0c07c77a606f479cffeb8adf3fee88c23da3d0a1"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "1a6026d18dde1e7722f71abe211ba55f9249c887"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "29f65d6e0e5be86fab9d639a79efe812ed29c115"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "5c14d500c3950ea8cb17e4ea91f9f063c32247c6"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "bf735f9b82fba889ad82605a69bc9ec2db46ea09"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "b9c22225a7a762db4b2c2039f200d37356660262"
LINUX_VERSION_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-nxp-s32g2xx ?= "97edafa2a1a1ae74a3d49a00ac2a7c89d602c9ff"
LINUX_VERSION_kb-v5.2-standard-nxp-s32g2xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "d7efa56097d2124fda8fa6b2ca44cae5eb023343"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "5663856821b24ad6f2492b4652c90606320f3e74"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "798a5fde83921cdfb63b0852023af99387aaea51"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "2b9b68e83f187f054ed5042b7efa095e162fc216"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "b59330bd6871e02b17b3eff07d5fb64fdba8f225"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "4a536acb5c4be474c5c9cd5c70fac1e33596eed4"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "2769a5987ebeaa27f5dbb4bc8681e7618e9e8bc8"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "d94f5a8ea5135a6922164481a685d71d4ed01694"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "28d78be988ff84192b926789f7767267e922be0e"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "b88bb34e2f452eb497a0e972cf3e1538ddc2ca69"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "cbbce37ccc6041d3ae3d3cb3b1918a61a39820a0"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "4fce24d64805733bce93c1fc488c5f5c54c4ffed"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.36"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "72994197096dc4d10707cc0f628bcd3e519cc082"
LINUX_VERSION_5.2 = "5.2.36"
