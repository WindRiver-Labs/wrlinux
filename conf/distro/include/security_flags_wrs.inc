# Base on oe-core security flags
include conf/distro/include/security_flags.inc

# To override for multilib, use SECURITY_CFLAGS_pn-<pkg>_pn-<mlib>-<pkg>.
# If just SECURITY_CFLAGS_pn-<pkg> is defined, it will be used for all
# multilib variants, too.
#

# Deal with ppc specific linker failures when using the cflags
SECURITY_CFLAGS_pn-glibc-initial_powerpc = ""
SECURITY_CFLAGS_pn-glibc_powerpc = ""
SECURITY_CFLAGS_pn-wireshark_powerpc = ""
SECURITY_CFLAGS_pn-rpm_powerpc64 = ""
SECURITY_STACK_PROTECTOR_pn-libmatchbox_powerpc = ""

# No _FORTIFY_SOURCE in CLFAGS
lcl_maybe_fortify_pn-c-ares = ""
lcl_maybe_fortify_pn-curl = ""
lcl_maybe_fortify_pn-openjdk-7 = ""
lcl_maybe_fortify_pn-openjdk-8 = ""
lcl_maybe_fortify_pn-relayd = ""
lcl_maybe_fortify_pn-libunwind = ""
lcl_maybe_fortify_pn-pth = ""

SECURITY_CFLAGS_pn-curlpp = ""
SECURITY_CFLAGS_pn-efitools = " "
SECURITY_CFLAGS_pn-grub-efi = " "
SECURITY_CFLAGS_pn-kexec-tools_mips64 = "-fstack-protector-all"
SECURITY_CFLAGS_append_pn-libhugetlbfs = " ${SECURITY_NOPIE_CFLAGS}"
SECURITY_CFLAGS_pn-squid = ""

TARGET_CFLAGS_remove_pn-lib32-directfb := "-fstack-protector-all -pie -fpie -D_FORTIFY_SOURCE=2"
TARGET_CFLAGS_remove_pn-directfb := "-fstack-protector-all -pie -fpie -D_FORTIFY_SOURCE=2"

SECURITY_LDFLAGS_remove_pn-dpdk = "-fstack-protector-strong"
SECURITY_LDFLAGS_remove_pn-libsign = "-fstack-protector-strong"

SECURITY_LDFLAGS_pn-netmap-modules_mips64 = " -z,relro,-z,now"
SECURITY_LDFLAGS_pn-cryptfs-tpm2 = ""

# Recipes which fail to compile when elevating -Wformat-security to an error
SECURITY_STRINGFORMAT_pn-boost = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '', '-Wformat -Wformat-security -Werror=format-security', d)}"
SECURITY_STRINGFORMAT_pn-dnrd = ""
SECURITY_STRINGFORMAT_pn-iperf = ""
SECURITY_STRINGFORMAT_pn-libunique = ""
SECURITY_STRINGFORMAT_pn-linux-atm = ""
SECURITY_STRINGFORMAT_pn-makedumpfile = ""
SECURITY_STRINGFORMAT_pn-mipv6-daemon-umip = ""
SECURITY_STRINGFORMAT_pn-mysql-connector-odbc = ""
SECURITY_STRINGFORMAT_pn-netkit-rpc = ""
SECURITY_STRINGFORMAT_pn-netkit-telnet = ""
SECURITY_STRINGFORMAT_pn-ocfs2-tools = ""
SECURITY_STRINGFORMAT_pn-rdate = ""
SECURITY_STRINGFORMAT_pn-selinux-autorelabel = ""
SECURITY_STRINGFORMAT_pn-setools = ""
SECURITY_STRINGFORMAT_pn-xfce4-notes-plugin = ""
