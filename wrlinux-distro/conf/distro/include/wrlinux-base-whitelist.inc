# This file controls the list of supported items when the wrlinux and related
# distributions are enabled.  Please keep the lists below sorted.

# Whitelist the whole wrlinux-distro layer
PNWHITELIST_LAYERS_remove = "wrlinux-distro"

# Define supported items from meta-openembedded
PNWHITELIST_filesystems-layer += ""

PNWHITELIST_meta-initramfs += ""
PNWHITELIST_multimedia-layer += ""

PNWHITELIST_networking-layer += " \
    freeradius \
    libtalloc \
    netcat \
    netcat-openbsd \
    postfix \
    tcpdump \
    crda \
    strongswan \
"

PNWHITELIST_openembedded-layer += " \
    agent-proxy-native \
    bonnie++ \
    fbset \
    fbset-modes \
    iotop \
    krb5 \
    lemon-native \
    libdbd-mysql-perl \
    libdbi-perl \
    libdev-checklib-perl \
    liblockfile \
    libmcrypt \
    lockfile-progs \
    mailx \
    mariadb \
    memstat \
    nmap \
    passwdqc \
    phoronix-test-suite \
    php \
    pmtools \
    postgresql \
    rfkill \
    sdparm \
    sg3-utils \
    syslog-ng \
    tclap \
    unixodbc \
    usleep \
    uw-imap \
    vlock \
    iperf3 \
    xmlsec1 \
"

PNWHITELIST_perl-layer += " \
    adduser \
    libipc-signal-perl \
    libmime-types-perl \
    libproc-waitstat-perl \
    logcheck \
    mime-construct \
"

PNWHITELIST_meta-python += " \
    python-dbus \
    python-pyrex-native \
    python3-django \
    python3-django-south \
    python3-pytz \
    nativesdk-python3-beautifulsoup4 \
    nativesdk-python3-pytz \
    python-m2crypto \
    python-typing \
    python3-pyyaml \
    python3-jinja2 \
    python3-markupsafe \
    python3-cython \
    python3-sqlparse \
"

PNWHITELIST_webserver += " \
    phpmyadmin \
    xdebug \
"

PNWHITELIST_xfce-layer += ""

PNWHITELIST_security += " \
    ecryptfs-utils \
    libgssglue \
    libmhash \
    samhain-client \
    samhain-server \
    samhain-standalone \
"

PNWHITELIST_integrity += " \
    ima-inspect \
    ima-evm-utils \
"

# Workaround for nmap possibly requiring python-pygtk which is not available
PACKAGECONFIG_remove_pn-nmap = "zenmap"

PNWHITELIST_selinux += " \
    audit \
"

PNWHITELIST_scanners-layer += " \
    openscap \
    scap-security-guide \
"
