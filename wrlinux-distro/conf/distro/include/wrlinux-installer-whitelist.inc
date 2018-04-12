PNWHITELIST_LAYERS_remove = "meta-anaconda"

# Whitelist for meta-openembedded/meta-gnome
PNWHITELIST_gnome-layer += "\
    gnome-themes \
    gtk-engines \
    keybinder \
    libgnomekbd \
    libgnome-keyring \
    libtimezonemap \
    metacity \
    network-manager-applet \
    usermode \
    libgtop \
"

# Whitelist for meta-openembedded/meta-python
PNWHITELIST_meta-python += "\
    python3-asn1crypto \
    python3-blivet \
    python3-blivetgui \
    python3-chardet \
    python3-certifi \
    python3-cffi \
    python3-coverage \
    python3-cryptography \
    python3-cryptography-vectors \
    python3-dbus \
    python3-idna \
    python3-iso8601 \
    python3-langtable \
    python3-meh \
    python3-ndg-httpsclient \
    python3-ntplib \
    python3-ordered-set \
    python3-pid \
    python3-pluggy \
    python3-ply \
    python3-prctl \
    python3-pretend \
    python3-py \
    python3-pyasn1 \
    python3-pycparser \
    python3-pykickstart \
    python3-pyopenssl \
    python3-pyparted \
    python3-pysocks \
    python3-pytest \
    python3-pytest-runner \
    python3-pytz \
    python3-pyudev \
    python3-requests \
    python3-requests-file \
    python3-requests-ftp \
    python3-setuptools-scm \
    python3-urllib3 \
    python3-wrapt \
"

# Whitelist for meta-openembedded/meta-filesystems
PNWHITELIST_filesystems-layer += "\
    fuse \
    ntfs-3g-ntfsprogs \
    xfsprogs \
"

# Whitelist for meta-openembedded/meta-oe
PNWHITELIST_openembedded-layer += "\
    augeas \
    efibootmgr \
    efivar \
    libpwquality \
    libreport \
    libtar \
    fltk \
    glade \
    gnome-doc-utils-stub \
    gnulib \
    isomd5sum \
    libndp \
    mozjs \
    networkmanager \
    polkit \
    satyr \
    tigervnc \
    uthash \
    xmlrpc-c \
"

