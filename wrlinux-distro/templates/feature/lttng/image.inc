IMAGE_INSTALL += "lttng-modules"
IMAGE_INSTALL += "lttng-tools"
IMAGE_INSTALL += "lttng-ust"
IMAGE_INSTALL += "babeltrace"
IMAGE_INSTALL += "python3-core"

IMAGE_INSTALL += "${@bb.utils.contains('DISTRO_FEATURES', 'api-documentation', 'lttng-tools-doc', '', d)}"

# To avoid build warnings, add this explicitly only if it would not get pulled
# in automatically.  Historically, we have provided this all the time.
#
IMAGE_INSTALL += "${@bb.utils.contains('IMAGE_FEATURES','dbg-pkgs','','lttng-ust-dbg',d)}"

