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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "e3dfd13ff45b68c960471dfa8cc73b410d3df9c2"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-base ?= "233931beaf6218ec910107637ec1e90e5c1682d2"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "dfe9f67507ccb405f7fc7c2d75a255688277c34a"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "ccca43bb78383b0a780c723bc147a3d7e0490d77"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "afd223c28ace01e627816da6c3fb74eb4c0ceb83"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "1f3f9825467c27bbfbf9f47a7f1921dcb55aab08"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "51f14632dfcb03ee59bcfb51c81f4525cb98724a"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "08f7c3f68243fc57cdc903ea2f8d86057fbf0fb6"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "a153705cf5e9171aac10ecaf3ef45f9ed8c9bf04"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "b0a4c003c127bbbf69af441244b30dbe6ce1c88b"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "39eb47a1b78bbf0df1d9a156a03b9153cbcced85"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "4d54223e8b51033bee87122c15eef05499d9de51"
LINUX_VERSION_kb-v5.2-standard-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-nxp-s32g2xx ?= "aaf3074d880f5c889030765bcd913b4bcd915692"
LINUX_VERSION_kb-v5.2-standard-nxp-s32g2xx ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "3a17d01f3366d26312c6b7b44425b6048e2233df"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "2829a72871dfca9629b1ce0dfba1e006574e64b2"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "2c95159a70068d8ecb1d29a10ee7f7bb9170bd64"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "0feb25878385b984eca1b8255e5306ec38275d01"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-nxp-imx-sdk-4.19.35-nxp-imx6 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "2acb602abcb53af7f7bf5979cf537c6cc2358956"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "41344469e68d14416f8520773041bd2df465f557"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "d42b849e76c0593da33db30af2ab5e2d2b19a1ff"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "228bab6f193e4f67d2527852eaf81944e188f0b2"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "7406fe139067ae24726fe1749258454df611af99"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "67578dd9e2ed6fe63b090c6578185a70744d7d06"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "29681d1fb4c23d6aaf4672562e5b66a3888d7ef3"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.37"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "dd7969bdf4a6c128107b0c0f1fb2abe93ecaa703"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.37"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "681685b7a1fc213997ff0e5032cf35e32bdeb51f"
LINUX_VERSION_5.2 = "5.2.36"
