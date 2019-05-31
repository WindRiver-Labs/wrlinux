# wrlinux-image-glibc-core is depreated, use wrlinux-image-core instead

inherit deprecate
ALTERNATIVE_NEW_RECIPE = "wrlinux-image-core"
require wrlinux-image-core.bb
