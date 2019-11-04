#
# Copyright (C) 2016 - 2017 Wind River Systems, Inc.
#
# Explicitly allow these recipes in wrlinux cgl
#

# Whitelist the whole wrlinux-cgl layer
PNWHITELIST_LAYERS_remove = "${@bb.utils.contains('DISTRO_FEATURES', 'cgl', 'wrlinux-cgl', '', d)}"

# Enable items for wrlinux-cgl distro
#
# For meta-cgl/meta-cgl-common
PNWHITELIST_cgl-common += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'cgl', '${PNWHITELIST_CGL_COMMON}', '', d)}  \
"
PNWHITELIST_CGL_COMMON = " \
    cluster-glue \
    crmsh \
    libmailtools-perl \
    libsocket6-perl \
    libtest-pod-perl \
    libwww-perl \
    ocfs2-tools \
    pacemaker \
    resource-agents \
    ucarp \
"

# For meta-openembedded/meta-python
PNWHITELIST_meta-python += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'cgl', '${PNWHITELIST_META_PYTHON}', '', d)}  \
"
PNWHITELIST_META_PYTHON = " \
    python-lxml \
    python-paste \
    python-vcversioner \
"

# For meta-openembedded/meta-networking
PNWHITELIST_networking-layer += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'cgl', '${PNWHITELIST_META_NETWORKING}', '', d)}  \
"
PNWHITELIST_META_NETWORKING = " \
    bridge-utils \
    c-ares \
    corosync \
    freediameter \
    geoip \
    geoip-perl \
    ifenslave \
    ippool \
    ipvsadm \
    iscsi-initiator-utils \
    libldb \
    libtdb \
    libtevent \
    lksctp-tools \
    netkit-rsh \
    netkit-telnet \
    ntop \
    ntp \
    openhpi \
    openipmi \
    open-isns \
    openl2tp \
    quagga \
    rdate \
    rdist \
    samba \
    tftp-hpa \
    tnftp \
    traceroute \
    tunctl \
    vblade \
    vlan \
    vsftpd \
"

# For meta-openembedded/meta-oe
PNWHITELIST_openembedded-layer += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'cgl', '${PNWHITELIST_META_OE}', '', d)}  \
"
PNWHITELIST_META_OE = " \
    crash \
    edac-utils \
    indent \
    ipmitool \
    libnet \
    libqb \
    postgresql \
    pps-tools \
    python-pygobject \
    smartmontools \
    zabbix \
"

# For meta-openembedded/meta-perl
PNWHITELIST_perl-layer += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'cgl', '${PNWHITELIST_META_PERL}', '', d)}  \
"
PNWHITELIST_META_PERL = " \
    libauthen-sasl-perl \
    libdigest-hmac-perl \
    libdigest-sha1-perl \
    libhtml-parser-perl \
    libhtml-tagset-perl \
    libio-socket-ssl-perl \
    libnet-dns-perl \
    libnet-dns-sec-perl \
    libnet-libidn-perl \
    libnet-ssleay-perl \
    libnet-telnet-perl \
    libtext-iconv-perl \
    libxml-filter-buffertext-perl \
    libxml-libxml-perl \
    libxml-sax-writer-perl \
"

# For meta-virtualization
PNWHITELIST_virtualization-layer += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'cgl', 'lxc', '', d)} \
"
