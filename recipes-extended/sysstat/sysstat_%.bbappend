PACKAGECONFIG_osv-wrlinux ?= "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)} lm-sensors cron"
