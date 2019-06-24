SUMMARY = "Application container for ${WR_APP_CONTAINER_APP}"
DESCRIPTION = "An application container which will run \
                ${WR_APP_CONTAINER_APP}."
HOMEPAGE = "http://www.windriver.com"

inherit wr-app-container

IMAGE_INSTALL += "${WR_APP_CONTAINER_APP}"
