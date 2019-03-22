PACKAGECONFIG_append = "${@bb.utils.contains('DISTRO_FEATURES', 'weston-demo', ' wayland ', ' ', d)}"
