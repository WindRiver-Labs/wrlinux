SUMMARY = "Packages required by bsp"

#
# packages which content depend on MACHINE_FEATURES need to be MACHINE_ARCH
#

ALLOW_EMPTY_${PN} = "1"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup


BSP_EXTRAS_PACKAGES ?= ""

PROVIDES = "${PACKAGES}"
PACKAGES = ' \
	    packagegroup-wr-bsps \
            ${@bb.utils.contains("MACHINE_FEATURES", "parser", "packagegroup-wr-bsps-parser", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "shell-tools", "packagegroup-wr-bsps-shell-tools", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "filesystem", "packagegroup-wr-bsps-filesystem-tools", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "profile", "packagegroup-wr-bsps-profile-tools", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "network", "packagegroup-wr-bsps-network-tools", "", d)} \
	    \
	    ${@bb.utils.contains("DISTRO_FEATURES", "bsp-extras", "packagegroup-wr-bsps-bsp-extras", "", d)} \
            '

#
# packagegroup-wr-bsps contain stuff needed by BSPs (machine related)
#
RDEPENDS_packagegroup-wr-bsps = "\
            ${@bb.utils.contains("MACHINE_FEATURES", "parser", "packagegroup-wr-bsps-parser", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "shell-tools", "packagegroup-wr-bsps-shell-tools", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "filesystem", "packagegroup-wr-bsps-filesystem-tools", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "profile", "packagegroup-wr-bsps-profile-tools", "", d)} \
            ${@bb.utils.contains("MACHINE_FEATURES", "network", "packagegroup-wr-bsps-network-tools", "", d)} \
	    \
	    ${@bb.utils.contains("DISTRO_FEATURES", "bsp-extras", "packagegroup-wr-bsps-bsp-extras", "", d)} \
    "

SUMMARY_packagegroup-wr-bsps-parser = "Parser Generator Support"
RDEPENDS_packagegroup-wr-bsps-parser = "\
	flex \
	bison"

SUMMARY_packagegroup-wr-bsps-shell-tools = "Shell tools support"
RDEPENDS_packagegroup-wr-bsps-shell-tools = "\
	dialog"

SUMMARY_packagegroup-wr-bsps-filesystem-tools = "Filesystem tools support"
RDEPENDS_packagegroup-wr-bsps-filesystem-tools = "\
	fio \
	smartmontools"

SUMMARY_packagegroup-wr-bsps-profile-tools = "Profile tools support"
RDEPENDS_packagegroup-wr-bsps-profile-tools = "\
	perf"

SUMMARY_packagegroup-wr-bsps-network-tools = "Network tools support"
RDEPENDS_packagegroup-wr-bsps-network-tools = "\
	iperf3"

SUMMARY_packagegroup-wr-bsps-bsp-extras = "BSP related extras devices tools"
RDEPENDS_packagegroup-wr-bsps-bsp-extras = "\
	${BSP_EXTRAS_PACKAGES} \
	"
