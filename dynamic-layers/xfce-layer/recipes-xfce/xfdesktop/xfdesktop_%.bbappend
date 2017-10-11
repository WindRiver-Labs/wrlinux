#
# Copyright (C) 2015 Wind River Systems, Inc.
#

OVERRIDES .= "${@bb.utils.contains('LICENSE_FLAGS_WHITELIST', 'commercial_windriver', ':wr-themes', '', d)}"

DEFAULT_WALLPAPER ?= "gray"

LICENSE_FLAGS_wr-themes = "commercial_windriver"

do_compile_prepend_wr-themes () {
	# we have several wallpapers for each theme, use the first one by default
	sed -i "s,\(/backgrounds/\)[-_/\.a-zA-Z0-9]*,\1Windriver/windriver-${DEFAULT_WALLPAPER}-1.jpg," \
		${S}/common/xfdesktop-common.h
}

RDEPENDS_${PN}_append_wr-themes = " wr-themes-wallpapers"
