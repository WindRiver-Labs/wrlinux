#
# Copyright (C) 2015 Wind River Systems, Inc.
#

DEFAULT_WALLPAPER ?= "gray"

do_compile_prepend () {
	# we have several wallpapers for each theme, use the first one by default
	sed -i "s,\(/backgrounds/\)[-_/\.a-zA-Z0-9]*,\1Windriver/windriver-${DEFAULT_WALLPAPER}-1.jpg," \
		${S}/common/xfdesktop-common.h
}

RDEPENDS_${PN} += "wr-themes-wallpapers"
