#
# This file is generated based on:
#     linux-yocto-4.18
#     yocto-kernel-cache
#
# Any manual changes will be overwritten.
#

# linux-yocto-4.18 entries
# This will cause SRCREV_machine_kb-<KBRANCH> take priority over SRCREV_machine_<machine>
MACHINEOVERRIDES .= ":kb-${@d.getVar('KBRANCH', True).replace("/", "-")}"

# linux-yocto-4.18 branch entries
SRCREV_machine_kb-master ?= "8a8c540db3ff1968317759961c0230221882367d"
LINUX_VERSION_kb-master ?= "4.18.3"
SRCREV_machine_kb-v4.18-base ?= "8a8c540db3ff1968317759961c0230221882367d"
LINUX_VERSION_kb-v4.18-base ?= "4.18.3"
SRCREV_machine_kb-v4.18-standard-arm-versatile-926ejs ?= "eb0ef26f2bac0cd84961eba7038e8ff10c6a6fb1"
LINUX_VERSION_kb-v4.18-standard-arm-versatile-926ejs ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-base ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-base ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-beaglebone ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-beaglebone ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-edgerouter ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-edgerouter ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "01da0fc68e3fa476424121ef134f1cf371f7f226"
LINUX_VERSION_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-intel ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-intel ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-intel-socfpga ?= "914def134112210908bce7a627106166d5072f79"
LINUX_VERSION_kb-v4.18-standard-intel-socfpga ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-intel-x86 ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-intel-x86 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-mti-malta32 ?= "7f7ea78d7b783413033d6adf45ec8952f8c98d60"
LINUX_VERSION_kb-v4.18-standard-mti-malta32 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-mti-malta64 ?= "db0ce433d9b74830d5b8dd3171ffbd7b1119cbfa"
LINUX_VERSION_kb-v4.18-standard-mti-malta64 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-preempt-rt-base ?= "5b9223498c5870c46d9c8bb87db649d00dad7abe"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-base ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel ?= "c9fb9006086581dd023b55d3a33afd91709e33c9"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel-x86 ?= "ba9e916993c4f0a02aa16c570909d01e7be73ab2"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel-x86 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-qemuarm64 ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-qemuarm64 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-qemuppc ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-qemuppc ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "5b8abdbe6fb783fe30c835ff63008eb43257f32c"
LINUX_VERSION_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-base ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-tiny-base ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-common-pc ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-tiny-common-pc ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-intel ?= "218a2500084b70dfe9cedd3856ec572563d55ace"
LINUX_VERSION_kb-v4.18-standard-tiny-intel ?= "4.18.17"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_4.18 = "yocto-4.18-wr"
SRCREV_meta_4.18 = "b83c6cc1a5df328e61a22a7eea3139b8f8959d91"
LINUX_VERSION_4.18 = "4.18.14"
