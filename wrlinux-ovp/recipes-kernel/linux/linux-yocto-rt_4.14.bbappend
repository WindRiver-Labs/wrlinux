# OVP specific include file
OVP_KERNEL_INCLUDE = ""

# If wrlinux-ovp
#   If WRLINUX_OVP_ENABLE != guest
#     set to linux-yocto-ovp-host.inc
#   else
#     set to linux-yocto-ovp-guest.inc
OVP_KERNEL_INCLUDE_wrlinux-ovp = "${@'linux-yocto-ovp-host.inc' if d.getVar('WRLINUX_OVP_ENABLE') != 'guest' else 'linux-yocto-ovp-guest.inc'}"

require ${OVP_KERNEL_INCLUDE}
