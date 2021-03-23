SUMMARY = "Wind River Linux Kiosk"
DESCRIPTION = "Enable kiosk mode for Chromium"
HOMEPAGE = "http://www.windriver.com"
SECTION = "x11"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://wr-chromium-web-kiosk.service \
           file://X.service \
           file://wr-chromium-web-kiosk.sh \
"

PACKAGECONFIG ??= "vkeyboard"
PACKAGECONFIG[vkeyboard] = ",,,chrome-virtual-keyboard"

inherit useradd features_check systemd

# system user & group named wr-kiosk
USERADD_PACKAGES = "${PN}"
USERADD_PARAM_${PN} = "-m -d /home/${PN} -U -r -s /bin/sh ${PN}"

# x11 is required for X.service
# systemd is required for any of the below service
REQUIRED_DISTRO_FEATURES = "x11 systemd"

SYSTEMD_AUTO_ENABLE_${PN} = "enable"
SYSTEMD_SERVICE_${PN} = "wr-chromium-web-kiosk.service X.service"

STARTING-URL ?= ""

# With no desktop manager resizing,
# need to explicitly specify the window-size...
#,Even if it is full-screen
WINDOW-SIZE ?= "1920,1080"
# Extensions: commas separated local unpacked URL
EXTENSIONS ?= "${@bb.utils.contains("PACKAGECONFIG", "vkeyboard", "${datadir}/chrome-virtual-keyboard", "", d)}"

# Allow disabling temporarily --kiosk to do manual preference configuration
# such as default zoom level, extension preferences, font preferences...
# Other flags that could be added:
# --incognito  (need to explicitly allow extensions if added)
# --no-sandbox (unsafe)
KIOSK-MODE-FLAG ?= "--kiosk --start-maximized"

do_install() {
    # services
    install -Dm 0644 ${WORKDIR}/wr-chromium-web-kiosk.service \
        ${D}${systemd_system_unitdir}/wr-chromium-web-kiosk.service
    sed -i -e 's#@LIBEXECDIR@#${libexecdir}#g' \
        ${D}${systemd_system_unitdir}/wr-chromium-web-kiosk.service

    install -Dm 0644 ${WORKDIR}/X.service ${D}${systemd_system_unitdir}/X.service

    # customizing script
    install -Dm 0755 ${WORKDIR}/wr-chromium-web-kiosk.sh ${D}${libexecdir}/wr-chromium-web-kiosk.sh
    sed -i -e 's#@EXTENSIONS@#${EXTENSIONS}#g'        \
        -e 's#@STARTING-URL@#${STARTING-URL}#g'       \
        -e 's#@WINDOW-SIZE@#${WINDOW-SIZE}#g'         \
        -e 's#@KIOSK-MODE-FLAG@#${KIOSK-MODE-FLAG}#g' \
        ${D}${libexecdir}/wr-chromium-web-kiosk.sh
}

FILES_${PN} += "${systemd_unitdir}"
FILES_${PN} += "${libexecdir}/wr-chromium-web-kiosk.sh"
