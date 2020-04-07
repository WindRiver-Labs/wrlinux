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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "12f787d91be75a1bd4f918cecbefcd79e8a47576"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-base ?= "7d7bd990dc37f830323e7dd504bd4ac1d1cd1ab3"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "b9a8b3675ba935ae88922f06b3eda9734903cf73"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "fe41453213db0124daa9a804a3123568f4e2be11"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "85b657dcf02dde0d3632434190abfad614ae86fd"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "5e2e3f960dceaf4df71574e899ed13fedbb0e4e3"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "c8278a37390ce6f01b49ee2a6ad58ae34d990dbf"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "022adbaec51f5143aee335efad1d745fce1aa1b0"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "7fd0457a1898d14f3e8c8ea607ece1925da8c832"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "330a895e5122310ce0e0121beb95149a82435754"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "e3fe1940868b9002779a8bbba333208cb0aade44"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "02e68ddda71cf05cd221fcd16d31db8123d23f4f"
LINUX_VERSION_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-nxp-s32g2xx ?= "2c9a2379aba039425f3b035af1d9250cbb19f503"
LINUX_VERSION_kb-v5.2-standard-nxp-s32g2xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "c3067c73b7f116b7e1c7d0ed4d5d634b8c1763c0"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "d4314a9fbe7385ab4f18108c35a52f4a40dcc92a"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "471312921b9a261228b345942577e8d90e078f3b"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "b03b65dcfbeeb4f3d695890143f6913578bccff4"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "985244b559ae3f5ca3fbdb0296d5e4fd1cad1dc5"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "4081099fa286103c6d9d85da73baf3b1bbc372e5"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "9d8613c17729a01bfbbd32af216bbdfca00291bc"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "265183ef2d02cb3d9f1495e6973f6956829511fd"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "88d2c2baca82bdc9cdfdb4cd3154759cda3544b3"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "763dc4ddb96f868ce89ac6e0d2d16ae9a3bb5136"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "60e18b269453a6fc75075780bb96d3ce1c3f0e44"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.36"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "a9516de4163381b11c275a3d8d0eaacceed62985"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.36"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "0750ac6a7103293a8d05e7e2b9d5773b3e860e5b"
LINUX_VERSION_5.2 = "5.2.36"
