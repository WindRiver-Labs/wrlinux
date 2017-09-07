# OVP specific configuration
#
# ovp enables libnuma-based memory binding support on Linux for x86_64 arch by default.
PACKAGECONFIG_x86-64_wrlinux-ovp = "numactl pci libxml2 ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11', '', d)}"
