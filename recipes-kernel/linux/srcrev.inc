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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "821fa6253c6f3bb3847d1ec10b85a88fbf53c9a9"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-base ?= "8cbd83ecafb9c55698c21c9f5e147e132116eeee"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "0b74b5073e0a56d271b34b736683fb16621b20b7"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "29f8e5e4f5b72abc979fc605a3fcc26803a79f71"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "270cc37193c7587172ec3a168b754d13a7df2132"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "3cc9bfa3e6a166105adb32a480d2d51cc3fb0ffa"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "cbbc14ce3d9b46b60be69d005d4e2f010257f65e"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "a5c4d6df11bbf2b854608ee3b65fa6048dc81d72"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "961b31d11e964dfb6e4f81042f198a205e051491"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "1e2e952729985979646d2727a1fa78d73881d657"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "78ecb059c9683468707d0fc36c693edbe278d9f4"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "00b91b0072778ab1925aa5ecd509ee4237cd667a"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "193ec1108531410131ad0b8de1e3392c556ff500"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "d903a466c3e0a8a785cca27fa3ff743d70395255"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "917958f2ecee63dd8479e159d832edcf7f3db37d"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "6e3e0768189f4cda62787cfc04af8495f20f8993"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "0727ed570ae32593ee3581e6ac2003619cd7e6b2"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "723e3fdb8068aa813dd73518d520cf6806fd0d67"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "e9640fb9e5821535c281ce00872b0401890e56db"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "1586e9d50e682657f344f0397c10d239ebd2c6a3"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "e12899d2e8588108e47ed299b6a65fb2fd445dfc"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.27"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "63d13229606f5e0017250520dd8710ab3e8af9db"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.27"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "2d935e11b8a0206667d1a2f3b21055db276a4e91"
LINUX_VERSION_5.2 = "5.2.27"
