# This file controls the list of supported items when the wrlinux and related
# distributions are enabled.  Please keep the lists below sorted.

# Whitelist the whole wrlinux-distro layer
PNWHITELIST_LAYERS_remove = "wrlinux-distro"

# Define supported items from meta-openembedded
PNWHITELIST_efl-layer += ""
PNWHITELIST_filesystems-layer += " \
	yaffs2-utils \
	"

PNWHITELIST_gnome-layer += " \
	dconf \
	gvfs \
	libwnck \
	libwnck3 \
	libxklavier \
	"

PNWHITELIST_gpe-layer += ""
PNWHITELIST_meta-initramfs += ""
PNWHITELIST_multimedia-layer += ""

PNWHITELIST_networking-layer += " \
	dnsmasq \
	ipsec-tools \
	libmnl \
	netcat \
	netcat-openbsd \
	postfix \
	tcpdump \
	"

PNWHITELIST_openembedded-layer += " \
	agent-proxy-native \
	atkmm \
	bonnie++ \
	cairomm \
	eject \
	eventlog \
	fbset \
	fbset-modes \
	glibmm \
	gnome-common-native \
	gtkmm \
	iceauth \
	iotop \
	iozone3 \
	jansson \
	lemon-native \
	libatasmart \
	libdbd-mysql-perl \
	libdbi-perl \
	libcanberra \
	libdevmapper \
	libestr \
	libfastjson \
	libgphoto2 \
	liblogging \
	libndp \
	libmcrypt \
        librelp \
	libsigc++-2.0 \
	libunique \
	lmbench \
	lmsensors \
	lmsensors-config \
	lvm2 \
	lxdm \
	mailx \
	mariadb \
	memstat \
	mm-common \
	mozjs \
	networkmanager \
	pangomm \
	pavucontrol \
	phoronix-test-suite \
	php \
	pmtools \
	polkit \
	rfkill \
	rrdtool \
	rsyslog \
	sdparm \
	setxkbmap \
	sg3-utils \
	sound-theme-freedesktop \
	syslog-ng \
	thin-provisioning-tools \
	udisks2 \
	unixodbc \
	upower \
	usleep \
	uw-imap \
	vim \
	vim-tiny \
	xrdb \
	"

PNWHITELIST_perl-layer += " \
	adduser \
	"

PNWHITELIST_meta-python += " \
	python-dbus \
	python-pyrex-native \
	nativesdk-python3-django \
	nativesdk-python3-django-south \
	nativesdk-python3-pip \
	"

PNWHITELIST_ruby-layer += ""
PNWHITELIST_systemd-layer += ""
PNWHITELIST_webserver += " \
	apache2 \
	phpmyadmin \
	xdebug \
	"

PNWHITELIST_xfce-layer += " \
	exo \
	exo-native \
	garcon \
	gtk-xfce-engine \
	libxfce4ui \
	libxfce4util \
	machine-host \
	packagegroup-xfce-base \
	thunar \
	thunar-archive-plugin \
	thunar-media-tags-plugin \
	thunar-volman \
	xfce4-appfinder \
	xfce4-battery-plugin \
	xfce4-clipman-plugin \
	xfce4-closebutton-plugin \
	xfce4-cpufreq-plugin \
	xfce4-cpugraph-plugin \
	xfce4-datetime-plugin \
	xfce4-dev-tools \
	xfce4-dev-tools-native \
	xfce4-diskperf-plugin \
	xfce4-embed-plugin \
	xfce4-fsguard-plugin \
	xfce4-equake-plugin \
	xfce4-eyes-plugin \
	xfce4-genmon-plugin \
	xfce4-mount-plugin \
	xfce4-netload-plugin \
	xfce4-notes-plugin \
	xfce4-notifyd \
	xfce4-panel \
	xfce4-places-plugin \
	xfce4-power-manager \
	xfce4-pulseaudio-plugin \
	xfce4-screenshooter \
	xfce4-session \
	xfce4-settings \
	xfce4-terminal \
	xfce4-systemload-plugin \
	xfce4-taskmanager \
	xfce4-time-out-plugin \
	xfce4-wavelan-plugin \
	xfce4-weather-plugin \
	xfce4-xkb-plugin \
	xfconf \
	xfdesktop \
	xfwm4 \
	"

