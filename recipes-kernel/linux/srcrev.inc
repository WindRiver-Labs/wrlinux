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
SRCREV_machine_kb-v4.18-standard-arm-versatile-926ejs ?= "fc10a65e12d9c6d1e0c63e19688727bc72922cdd"
LINUX_VERSION_kb-v4.18-standard-arm-versatile-926ejs ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-base ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-base ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-beaglebone ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-beaglebone ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-edgerouter ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-edgerouter ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "39a70534c2e3b61ebd3e5982e94eaa69df02e29b"
LINUX_VERSION_kb-v4.18-standard-fsl-mpc8315e-rdb ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-intel ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-intel ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-intel-socfpga ?= "f5fd2b3b0a7f42114d86107a8d0858ea2295d0cb"
LINUX_VERSION_kb-v4.18-standard-intel-socfpga ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-intel-x86 ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-intel-x86 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-mti-malta32 ?= "d3ecc257838be6d1a15e1eb114ee960283bacf33"
LINUX_VERSION_kb-v4.18-standard-mti-malta32 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-mti-malta64 ?= "48c3bf17f2c4699c9ee442c62ecdaad85fdb4232"
LINUX_VERSION_kb-v4.18-standard-mti-malta64 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-preempt-rt-base ?= "420a1d5ae972845413713ce882570f772423049f"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-base ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel ?= "5d0d4ea6bc56a97c32ea8f076934d2d70abd720d"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-preempt-rt-intel-x86 ?= "1dca8cebfe21130ed472a5393b9120c500d75c5e"
LINUX_VERSION_kb-v4.18-standard-preempt-rt-intel-x86 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-qemuarm64 ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-qemuarm64 ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-qemuppc ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-qemuppc ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-ti-am335x ?= "142bcf25097dfcf11919c228df5fc70b0d3d8f62"
LINUX_VERSION_kb-v4.18-standard-ti-am335x ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "26f444925aa62171e79a155bec72f055502cbce2"
LINUX_VERSION_kb-v4.18-standard-tiny-arm-versatile-926ejs ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-base ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-tiny-base ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-common-pc ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-tiny-common-pc ?= "4.18.17"
SRCREV_machine_kb-v4.18-standard-tiny-intel ?= "e78a46f375febc5f9305b6f94ae12fbf00b46330"
LINUX_VERSION_kb-v4.18-standard-tiny-intel ?= "4.18.17"

# yocto-kernel-cache entries
KERNEL_CACHE_BRANCH_4.18 = "yocto-4.18-wr"
SRCREV_meta_4.18 = "b8d927e483537106235183794e17ba32d5c709ed"
LINUX_VERSION_4.18 = "4.18.17"
