EXTRA_IMAGEDEPENDS += "unfs3-native"
EXTRA_IMAGEDEPENDS += "syslinux-native"
EXTRA_IMAGEDEPENDS += "qemu-native"
EXTRA_IMAGEDEPENDS += "qemu-helper-native"
EXTRA_IMAGEDEPENDS += "e2fsprogs-native"
EXTRA_IMAGEDEPENDS += "gdb-cross-${TARGET_ARCH}"

# copied from meta-mentor/conf/distro/include/sstate.inc
def lsb_distro_adjust(distro_id, ver):
    """This hook ensures that RHEL server, RHEL client, and CentOS all return
    'RedHat' for distro, and '5' for the version, as we know minor
    versions for these distros are compatible, and these distros are
    compatible with one another."""

    if distro_id in ('RedHatEnterpriseClient', 'RedHatEnterpriseServer',
                     'CentOS'):
        distro_id = 'RedHat'

        try:
            major_ver, _ = ver.split('.', 1)
        except ValueError:
            pass
        else:
            ver = major_ver
    return distro_id, ver

LSB_DISTRO_ADJUST = "lsb_distro_adjust"
