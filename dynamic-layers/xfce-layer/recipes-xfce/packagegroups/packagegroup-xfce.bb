SUMMARY = "All packages for full XFCE installation"
SECTION = "x11/wm"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

inherit packagegroup distro_features_check

# rdpends on xfce packages that need x11
REQUIRED_DISTRO_FEATURES = "x11"

# mozjs can NOT be built on mips64
COMPATIBLE_HOST = "^(?!mips64).*"

# mandatory
RDEPENDS_${PN} = " \
    packagegroup-xfce-base \
    wr-themes \
"

# nice to have
RRECOMMENDS_${PN} = " \
    thunar-archive-plugin \
    thunar-media-tags-plugin \
    xfce4-appfinder \
    xfce4-battery-plugin \
    xfce4-clipman-plugin \
    xfce4-closebutton-plugin \
    xfce4-cpufreq-plugin \
    xfce4-cpugraph-plugin \
    xfce4-datetime-plugin \
    xfce4-diskperf-plugin \
    xfce4-embed-plugin \
    xfce4-equake-plugin \
    xfce4-eyes-plugin \
    xfce4-fsguard-plugin \
    xfce4-genmon-plugin \
    xfce4-mount-plugin \
    xfce4-netload-plugin \
    xfce4-notes-plugin \
    xfce4-places-plugin \
    xfce4-power-manager \
    xfce4-powermanager-plugin \
    xfce4-pulseaudio-plugin \
    xfce4-screenshooter \
    xfce4-systemload-plugin \
    xfce4-taskmanager \
    xfce4-time-out-plugin \
    xfce4-wavelan-plugin \
    xfce4-weather-plugin \
    xfce4-xkb-plugin \
    xfwm4-theme-daloa \
    xfwm4-theme-kokodi \
    xfwm4-theme-moheli \
    xrdb \
"
