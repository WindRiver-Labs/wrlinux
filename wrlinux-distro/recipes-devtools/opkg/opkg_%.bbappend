# Set packages feed for opkg, the format is like:
#OPKG_EXTERNAL_FEED_URL = "\n\
#src oe http://feed_url.com\n\
#src oe-all http://feed_url.com/all\n\
#src oe-core2-64 http://feed_url.com/core2-64\n\
#src oe-qemux86_64 http://feed_url.com/qemux86_64\n\
#"

OPKG_EXTERNAL_FEED_URL ?= ""

do_install_append() {
    if [ -n "${OPKG_EXTERNAL_FEED_URL}" ]; then
        echo -e "${OPKG_EXTERNAL_FEED_URL}" >>${D}${sysconfdir}/opkg/opkg.conf
    fi
}
