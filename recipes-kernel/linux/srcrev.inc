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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "29f4bd916b316035d9e61533fc013de18878a66c"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-base ?= "ef54f0ac8d7caf7cc69f24b69de4633f796a4850"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "f3ef0e6bef98e475e171e806237e38506b6f71f0"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "75d324ed0b822e33a9ab0cc550d8789e91948760"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "a6f8941d10b37c9cfdd40e61a39b815b1ce1b13d"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "232380309b71b527cdb4c513caf4f84d3025cfbd"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "46bbe5ca1718bab8a24f5bb2aa8d32fcf2b7a1e7"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "ca36adb6eab2f5780458448b4c1dd34eb79d2954"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "37deb832e8aa669ababdc689420a640d481bfc25"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "7ab136af0d2ac460d49214bdee90368dff3176e9"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "436c232c83ed7bb822c3ef6ddb2a097954ade5c6"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "b944dfe47abe9c1ab0454cf1518965ff4ef060b2"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "c6a6357b2e2f4f8bd59302bd484c1fff92b02935"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.26"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "5db292f2202443b974694c8b9e3464963391187c"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.26"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "2bb67ad2db8df1b3d1c8d633f8f87e0d2064c66d"
LINUX_VERSION_5.2 = "5.2.26"
