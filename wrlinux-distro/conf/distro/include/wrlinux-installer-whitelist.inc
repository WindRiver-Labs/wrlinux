PNWHITELIST_LAYERS_remove = "meta-anaconda"

# Whitelist for meta-openembedded/meta-gnome
PNWHITELIST_gnome-layer += "\
    gnome-themes \
    gtk-engines \
    keybinder \
    libgnomekbd \
    libgnome-keyring \
    libtimezonemap \
    libuser \
    metacity \
    network-manager-applet \
    usermode \
    libgtop \
"

# Whitelist for meta-openembedded/meta-python
PNWHITELIST_meta-python += "\
    python3-blivet \
    python3-blivetgui \
    python3-coverage \
    python3-langtable \
    python3-meh \
    python3-ntplib \
    python3-ordered-set \
    python3-pid \
    python3-prctl \
    python3-pydbus \
    python3-pykickstart \
    python3-pyparted \
    python3-pytz \
    python3-pyudev \
    python3-requests-file \
    python3-requests-ftp \
    python3-setuptools-scm \
    python3-systemd \
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
    libpwquality \
    libreport \
    libtar \
    fltk \
    glade \
    gnome-doc-utils-stub \
    gnulib \
    isomd5sum \
    satyr \
    tigervnc \
    uthash \
    xmlrpc-c \
"

