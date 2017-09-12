# This file controls the list of supported items when the wrlinux and related
# distributions are enabled.  Please keep the lists below sorted.

# Whitelist the whole wrlinux-distro layer
PNWHITELIST_LAYERS_remove = "wrlinux-distro"

# Define supported items from meta-openembedded
PNWHITELIST_filesystems-layer += " \
	yaffs2-utils \
	"

PNWHITELIST_gnome-layer += " \
	libwnck3 \
	"

PNWHITELIST_meta-initramfs += ""
PNWHITELIST_multimedia-layer += ""

PNWHITELIST_networking-layer += " \
	dnsmasq \
	freeradius \
	ipsec-tools \
	libtalloc \
	netcat \
	netcat-openbsd \
	postfix \
	tcpdump \
	"

PNWHITELIST_openembedded-layer += " \
	agent-proxy-native \
	bonnie++ \
	cryptsetup \
	eventlog \
	fbset \
	fbset-modes \
	iotop \
	krb5 \
	lemon-native \
	libdbd-mysql-perl \
	libdbi-perl \
	liblockfile \
	libmcrypt \
	lockfile-progs \
	mailx \
	mariadb \
	memstat \
	passwdqc \
	phoronix-test-suite \
	php \
	pmtools \
	rfkill \
	sdparm \
	sg3-utils \
	syslog-ng \
	unixodbc \
	usleep \
	uw-imap \
	vim \
	vim-tiny \
	vlock \
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
	"

PNWHITELIST_webserver += " \
	phpmyadmin \
	xdebug \
	"

PNWHITELIST_xfce-layer += ""

PNWHITELIST_security += " \
	ecryptfs-utils \
	keynote \
	keyutils \
	libgssglue \
	libmhash \
	nmap \
	xmlsec1 \
	"
# Workaround for nmap possibly requiring python-pygtk which is not available
PACKAGECONFIG_remove_pn-nmap = "zenmap"
	
PNWHITELIST_selinux += ""
