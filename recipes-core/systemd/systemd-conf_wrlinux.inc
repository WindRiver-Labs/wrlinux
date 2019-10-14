#
# Copyright (C) 2019 Wind River Systems, Inc.
#

pkg_postinst_${PN}_append() {
    mkdir -p $D${sysconfdir}/systemd/network
    ln -sf /dev/null $D${sysconfdir}/systemd/network/80-wired.network
}
