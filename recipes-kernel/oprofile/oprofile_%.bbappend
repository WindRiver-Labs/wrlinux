# This runtime dependency is something that WRLinux needs but not OE.
# This is because that OE's default busybox provides `pidof' command.
RDEPENDS_${PN}_append_wrlinux = " ${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'sysvinit-pidof', '', d)}"
RDEPENDS_${PN}_append_wrlinux-std-sato = " ${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'sysvinit-pidof', '', d)}"
