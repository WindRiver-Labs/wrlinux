#
# Copyright (C) 2017 Wind River Systems, Inc.
#
DEPENDS += "${@bb.utils.contains('DISTRO_FEATURES', 'clvm', 'corosync dlm', '', d)}"

EXTRA_OECONF += "${@bb.utils.contains('DISTRO_FEATURES', 'clvm', '--with-cluster=internal --with-clvmd=corosync --enable-cmirrord', '', d)}"

SYSTEMD_SERVICE_${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'clvm', 'lvm2-cluster-activation.service lvm2-cmirrord.service lvm2-clvmd.service', '', d)}"

FILES_${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'clvm', '${systemd_unitdir}/lvm2-cluster-activation', '', d)}"
