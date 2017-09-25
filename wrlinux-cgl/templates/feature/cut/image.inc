
# The gdb.sh testcase needs gdb
# and multithreaded debugging needs libc-dbg
IMAGE_INSTALL += "gdb glibc-dbg"

IMAGE_INSTALL += "lksctp-tools-ptest"

# the iscsi testcase needs iscsitarget
IMAGE_INSTALL += "iscsitarget"

# the libevent testcase needs libevent-testing
IMAGE_INSTALL += "libevent-testing"

# the openl2tp testcase needs openl2tp-testing
#IMAGE_INSTALL += "openl2tp-testing"

# kdump CUT cases needs /boot/vmlinux
IMAGE_INSTALL += "kernel-vmlinux"
