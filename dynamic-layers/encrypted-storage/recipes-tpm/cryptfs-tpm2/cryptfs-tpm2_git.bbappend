require ${@bb.utils.contains('DISTRO_FEATURES', 'luks', 'wr-cryptfs-tpm2.inc', '', d)}
