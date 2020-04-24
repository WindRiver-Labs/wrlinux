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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "90ec158ca1c27c8afc1bafb8da4ecff6d6b31284"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-base ?= "3942005f7447188712acae1bdce2f20a3cda8d1a"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "8ccdb45bacf05c2deb7e1a70413f44860970bda1"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "1ad811a7b07a20f25cc41e95ff083c2fdf8ab15e"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "f166723a782f9dc86c7241f46b9c965533a05398"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "27915803fb41209123be9a1c5016126145fb3938"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "f95704d89680d3a4ec9a1c74dfaf7655ee415e87"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "4cc2f07d69bf41a58b0c8413a12a05d1cdcf3ad8"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "33273e5adbcbcd93b7aa937db35c30e55b02c847"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "2844f596556e16a3587ac9916a88ea424cf22d1f"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "5ef1bd771f3e33c1da3a2cc97ac7d02d25f6d3e0"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "b909d4ebe6ade8d1a6e13abfa0d19c2e27904779"
LINUX_VERSION_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-nxp-s32g2xx ?= "b76ad4b47442bbf2b0e4a0bee6a48237a28536f1"
LINUX_VERSION_kb-v5.2-standard-nxp-s32g2xx ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "652ea16c3ae3eb7895c8fa21ef44c0dc7163f957"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "ca30ff39397d185cfe45cdd4d7c4b66175228ebd"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "58ea2fb311b3139d3e113ce2bf5e78fed89f0ac0"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "d000c05e867122bddad06386a6d118e7081d1fb1"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "4bec0ee31554d9d50f295dd866a558591fcdc995"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "d5fdb5b048668948e273e36b10af1b4cead4f7a8"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "848ba294e8e498afd30191350ade0519d3a32845"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "e2bce0544e0e1acf4ec439479b4751f48d9f6b8b"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "e6e7b373b60612a728f5dbcf08e2498194d4db90"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "6b8bd7b0b057b64cedc52e4bdac783404fd5cb32"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "3942005f7447188712acae1bdce2f20a3cda8d1a"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.38"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "5511662eb7d5b5af221649d178eb00265270f9c4"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.38"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "b690bbac654e1dfda0121fcbf23cb6721a01d9f1"
LINUX_VERSION_5.2 = "5.2.38"
