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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "8411e789d260bba5ddaba877cde7b6d8abc5e469"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-base ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "b734f3a40ff8fb15cc815b0ff9825b1753899a09"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "ea644ca0c23daa58925be27754d0cac01ed50e9b"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "75973769f5ef18731a1c6806ee6dff66eaed50ea"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "84b424080a0e59b822de6ed1b44aab60e8d98a23"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "32631fbf2c0f111f70e7fee2a5afafa965b4471a"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "8a4fd4960c04d1127353900009669aafe5ede446"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "8d8955f7520ee85d2716e0b5b2b7ed532e165572"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "bb5830596ab08eeb25d6d7d4d1b46bfc84660e57"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "1d6d6a1b5222ed6c19feb191417df8b73c288f5f"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "868ad6ce10435d6e1624304dc944b5b91d580981"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "cbb85d7d6109a35b8ffd1b359d7c024362416141"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.21"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "59926b90cecb089a39248ea7c4ab93f42f6443f7"
LINUX_VERSION_5.2 = "5.2.21"
