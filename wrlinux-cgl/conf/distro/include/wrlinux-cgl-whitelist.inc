#
# Copyright (C) 2016 - 2017 Wind River Systems, Inc.
#
# Explicitly allow these recipes in wrlinux cgl
#

# Whitelist the whole wrlinux-cgl layer
PNWHITELIST_LAYERS_remove = "wrlinux-cgl"

# Enable items for wrlinux-cgl distro
#
# For meta-cgl/meta-cgl-common
PNWHITELIST_cgl-common_append = " \
    cluster-glue \
    crmsh \
    libhtml-tagset-perl \
    libmailtools-perl \
    libsocket6-perl \
    libtest-pod-perl \
    libwww-perl \
    monit \
    ocfs2-tools \
    pacemaker \
    resource-agents \
    ucarp \
"

# For meta-openembedded/meta-python
PNWHITELIST_meta-python_append = " \
    python-cffi \
    python-lxml \
    python-paste \
    python-ply \
    python-pyasn1 \
    python-pycparser \
    python-six \
    python-vcversioner \
"

# For meta-openembedded/meta-networking
PNWHITELIST_networking-layer_append = " \
    bridge-utils \
    c-ares \
    corosync \
    freediameter \
    geoip \
    geoip-perl \
    ifenslave \
    inetutils \
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
    strongswan \
    tftp-hpa \
    tnftp \
    traceroute \
    tunctl \
    vblade \
    vlan \
    vsftpd \
"

# For meta-openembedded/meta-oe
PNWHITELIST_openembedded-layer_append = " \
    crash \
    edac-utils \
    indent \
    ipmitool \
    libnet \
    libqb \
    numactl \
    postgresql \
    pps-tools \
    python-pygobject \
    smartmontools \
"

# For meta-openembedded/meta-perl
PNWHITELIST_perl-layer_append = " \
    libauthen-sasl-perl \
    libdigest-hmac-perl \
    libdigest-sha1-perl \
    libhtml-parser-perl \
    libio-socket-ssl-perl \
    libnet-dns-perl \
    libnet-libidn-perl \
    libnet-ssleay-perl \
    libnet-telnet-perl \
    libtext-iconv-perl \
    libxml-filter-buffertext-perl \
    libxml-libxml-perl \
    libxml-sax-writer-perl \
"

# For meta-virtualization
PNWHITELIST_virtualization-layer_append = " \
    lxc \
"
