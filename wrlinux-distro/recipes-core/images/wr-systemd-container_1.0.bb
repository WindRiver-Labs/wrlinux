SUMMARY = "Systemd system container for ${WR_SYSTEMD_CONTAINER_APP}"
DESCRIPTION = "A systemd system container which will run \
                ${WR_SYSTEMD_CONTAINER_APP}."
HOMEPAGE = "http://www.windriver.com"


# Use local.conf to specify the application(s) to install
IMAGE_INSTALL = "${WR_SYSTEMD_CONTAINER_APPS}"

# Use local.conf to specify additional systemd services to disable. To overwrite
# the default list use SERVICES_TO_DISABLE_pn-wr-systemd-container in local.conf
SERVICES_TO_DISABLE_append += "${WR_SYSTEMD_CONTAINER_DISABLE_SERVICES}"

# Use local.conf to enable systemd services
SERVICES_TO_ENABLE += "${WR_SYSTEMD_CONTAINER_ENABLE_SERVICES}"

require wr-systemd-container.inc
