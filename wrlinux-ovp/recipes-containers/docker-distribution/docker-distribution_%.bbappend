# OVP specific configuration
#
# We only support docker-distribution on x86_64 for OVP.
# Set COMPATIBLE_HOST to disable building on other archs.

COMPATIBLE_HOST_wrlinux-ovp = "x86_64.*-linux"
