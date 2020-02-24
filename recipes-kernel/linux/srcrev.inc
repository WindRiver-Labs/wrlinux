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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "6f06422d3c59d08d010da095e59d6da576f15233"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-base ?= "c926964d00caf714f42878535af8c7374452072d"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "55d01bfd7cc5c27f72471f60a8343f2a64914a1f"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "fd2dbd892800c277b300cb2236933a6b2f86a1a6"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "1cb1148db93b84a790b336004c4c3ac4ae7ddd0a"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "5bfbd9fe39ce9bf4c03ffaf38aa3e8515332270e"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "80358b17ff5bfd5cc127a6f1ef7ebc38d397065a"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-intel-socfpga ?= "691e7874b48e95e8d918a4a628281b8c1cf9fddc"
LINUX_VERSION_kb-v5.2-standard-intel-socfpga ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "fb95288b8cd07a5d90589c22c80df6b7090cefe6"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "279967bbd7ec0aef5285a96e9a3cdb8064778ca6"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "ea16def16eeb0b3ba788d434dde076ee46068f82"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "31535f4417507539bf1ac09b0fb8cf993095ceb7"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "196e374be3d05388eac426edcdebad260822f035"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "57519e6324606caa813b14ab3895cfc5ec07bf5b"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "ca9f2d29fea6c4c9e1371cecf5d7be5c267c1bd3"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "85184e3f1e03928d14d3be28ded7d7dfa0b764f4"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "3b7d5e75ea5bc0936f96ed27c2ac1c493997ce33"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "ff6e1258716bc44d27985ddef93827facf8ca852"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "78c874ec07764af089e450a251bb2bfa12a3bcbc"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "50c2a8c1fcac55f7e66d1964c4a99d379fe97f48"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-wr-base ?= "b943af74edb5c83ee3b90ea668e616b50a6512a4"
LINUX_VERSION_kb-v5.2-standard-wr-base ?= "5.2.32"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "b78dedf9c3171d28e79ce3c01b752dae32aab435"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.32"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "6b5e56084384941d524f4c9d21a078310a41b7d1"
LINUX_VERSION_5.2 = "5.2.32"
