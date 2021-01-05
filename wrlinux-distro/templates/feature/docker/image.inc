# add install lxc user code
#
IMAGE_INSTALL += "docker python3-docker-compose"
IMAGE_INSTALL += "${@bb.utils.contains('PACKAGE_CLASSES','package_deb','containerd-opencontainers','virtual/containerd',d)}"

