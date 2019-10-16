# In our system, both connman and systemd-resolved cannot set up
# resolv.conf correctly. Only dhclient can correctly do that.
# So the following is a workaround to make dhclient start on eth0 so
# that we can get correct resolv.conf file.
#
# We need to remove this workaround once we have made systemd-resolved
# or connman work correctly.

SYSTEMD_AUTO_ENABLE_${PN}-client = "enable"

do_install_append () {
    install -d ${D}${sysconfdir}/default/
    echo 'INTERFACES="eth0"' > ${D}${sysconfdir}/default/dhcp-client
}

# Since FILES_dhcp-client is used in the recipe, we have to use it
# here so that multilib works.
#
FILES_${PN}-client_append = " ${sysconfdir}/default/dhcp-client"
