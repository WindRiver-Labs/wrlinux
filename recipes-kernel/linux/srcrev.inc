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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "170bd5d0e95e2be1f1d6bef4425eb9b49a1da5bf"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-base ?= "9849667dadfa14d95cde6ab3d60a94a2756a8ac1"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "5efc788932839326f103848676f4dff06ec65461"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "a4a41492917dff1e169423d1e4dcbca7f732e301"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "27d79064632c378e60838e78577fe1f4852ac6cf"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "f8b7d650054187a07fcfe3e4f87953099d74e740"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "80deb98f3ff433e06da648d3e6226c1c6a6b2c84"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "17b8792d4d8287c1fdf4d5dadb2b4f909c269f10"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "dbd16a02c26428266440fd66e6e4e0a91c9772ea"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "818bec17d030e2c1beb64edbc8d646e143463195"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "bdea96ba387d184fc66761845fe65f840cfca407"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "628199f7e7cf731f18b740fcfbd5cc0476401c78"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "7e9084cc7cd720e4db8779343936a00fb3b8f4b6"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "62dfb38d87ab67a123953cad343d008a77815c33"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "ee4d5ba7a508702f9b70560a541f0e51c43fab4f"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "4537dbd9be496e7c9b4bedb8594037e413b577d9"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "677105600f652c0d8c7f5aab4fb2c39bfa77c901"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "2580f8cba705438a52bfc9ec7990e6becb5ddd39"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "f48508ffa4d76c79050ff85712851774c0e4fbba"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "57f3163c0a9c5ab452ef8744f897b333cf35211d"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "b2ad6059f0286c5d0595e56fe0f77c920c57e2be"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.31"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "a492c771e4ab90664e43af0398cfc85170913a9e"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.31"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "82cf90793d149904e09427f5fc1d76b3dbf47cfd"
LINUX_VERSION_5.2 = "5.2.31"
