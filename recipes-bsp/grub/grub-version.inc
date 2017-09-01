python () {
    grub_flavor = 'grub'

    if d.getVar('TARGET_ARCH', True).startswith('x86_64'):
        #
        # Choose the correct multilib for grub.
        # x86_64 support was added in grub 1.91.
        # If grub is older than that, use lib32-grub instead.
        #
        if d.getVar('PREFERRED_VERSION_grub', False) and \
          base_version_less_or_equal('PREFERRED_VERSION_grub', '1.90', \
          True, False, d):
            grub_flavor = 'lib32-grub'

    # Pass the appropriate grub flavor up to packagegroup-wr-boot.
    d.appendVar('WR_MACHINE_ESSENTIAL_EXTRA_RDEPENDS', ' ' + grub_flavor)
}
