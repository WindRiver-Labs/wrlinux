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
SRCREV_machine_kb-v5.2-standard-arm-versatile-926ejs ?= "bfd6aa9464c2df3895f50d136e733963cccb1565"
LINUX_VERSION_kb-v5.2-standard-arm-versatile-926ejs ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-base ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-bcm-2xxx-rpi ?= "566c058169e93921026cdc8dfbb86ef7c30f9fd1"
LINUX_VERSION_kb-v5.2-standard-bcm-2xxx-rpi ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-beaglebone ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-beaglebone ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-cn96xx ?= "3161931eb3a89c6e2d1c661ba48ba16b2fa349fc"
LINUX_VERSION_kb-v5.2-standard-cn96xx ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-edgerouter ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-edgerouter ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "e5c4a892a461645d01193d8d676a8ae0a0530cda"
LINUX_VERSION_kb-v5.2-standard-fsl-mpc8315e-rdb ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-intel-x86 ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-mti-malta32 ?= "0606117b25e47a7d15d4c6468d1384e0965b9f6c"
LINUX_VERSION_kb-v5.2-standard-mti-malta32 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-mti-malta64 ?= "38b48d80bc4cb9f53dc66ffa64678960d35622e5"
LINUX_VERSION_kb-v5.2-standard-mti-malta64 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-base ?= "e1a474b02f05ff3c525f85384ef00b2995e7fe04"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-cn96xx ?= "8d07d427e672b608c09604bb69b569f8e709aadc"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-cn96xx ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-preempt-rt-intel-x86 ?= "3fd7fbbb09647e936a5bd89fe4e296b5eb83ab41"
LINUX_VERSION_kb-v5.2-standard-preempt-rt-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-qemuarm64 ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-qemuarm64 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-qemuppc ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-qemuppc ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5ad592f5f4c3a91028cab1173c3b0f9a400085a6"
LINUX_VERSION_kb-v5.2-standard-tiny-arm-versatile-926ejs ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-base ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-tiny-base ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-common-pc ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-tiny-common-pc ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-tiny-intel-x86 ?= "687ae878843fe5baf9493db58b322f39415c7182"
LINUX_VERSION_kb-v5.2-standard-tiny-intel-x86 ?= "5.2.21"
SRCREV_machine_kb-v5.2-standard-xlnx-soc ?= "e9a81ba6a58de13990cf62784110f4f502805cea"
LINUX_VERSION_kb-v5.2-standard-xlnx-soc ?= "5.2.21"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_5.2 = "yocto-5.2-wr"
SRCREV_meta_5.2 = "59926b90cecb089a39248ea7c4ab93f42f6443f7"
LINUX_VERSION_5.2 = "5.2.21"
