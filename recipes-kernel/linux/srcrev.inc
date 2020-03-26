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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "d43fe7cec45d2e42d33d23afaf6fc1d8a5a9d41c"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-base ?= "327a2b432570ef637309ca4f78e64b3d3773e8c0"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "4ca27d2101b0afc84ac0adb27e5f47bbd1f287bd"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "52fe42725b2fd7ecaddd745fda8fb3cd8386924a"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "fd506da4cb2d050e1e7a82dfc31e93c1dd284209"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "53501bdccd676a8bea458c6e897b436ba75c3fe8"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "82303e54edad2be3709fa73c8b6e65fab84f0752"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "3ab77bd807a693acf980da2ed427813f10a8d24d"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "95b14ba9ac178acf8aa1171ea7ce3cc40fa910d6"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "dc6c03e38fc4699782a530c8b0504e48d456bc8e"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "b62eea6eff0b32f916a760930fff2a39fbed94fb"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "73feb60bc1f72d05c65bb3d87ea96ad7cee7fe8d"
LINUX_VERSION_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-nxp-s32g2xx ?= "f3ba576a8cbdb730c9e051b47591352a56a7d396"
LINUX_VERSION_kb-v5.2-standard-nxp-s32g2xx ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "b07df2e50ac818eee60301c134ea8a0b1f6dd720"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "0f9df61a34a1fcf0f5b385645b7fa215dc5c2a9c"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "a897f747228fb7f19a2ec3c53e1c8bfe7ea212bc"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "0b14d4b5e7216074ada87648842aa144d56a79f7"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "486c6dd2840a96b2786a47e90947d46930ad9c31"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "240549ac3a67a3745efe8ea7d9aeab9fcb4c430e"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "36fedec7a00c2cd7d14f70c8c2a17d097da5dd5b"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "193abe55328b68780a1ee13c484ba8b66f4cab38"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "a2a8b9bf600823d4e8599f37ddc6b6f5d5d2b1a8"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "09b7855ad7e0c4e0a71fa5fe5c6ee44fdb8787a2"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "aa8d60da8b3cd749bf7ad37666bcbff4efd33bad"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.33"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "3935c27a2b45ead910adeb2e8538f65d0cada65e"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.33"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "1b4aa1b833b2a0c2290d0581479fa088164663ee"
LINUX_VERSION_5.2 = "5.2.33"
