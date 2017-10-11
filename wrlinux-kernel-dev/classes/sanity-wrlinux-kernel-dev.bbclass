addhandler kerneldev_layer_enable_check
kerneldev_layer_enable_check[eventmask] = "bb.event.ConfigParsed"
python kerneldev_layer_enable_check() {
    skip_check = e.data.getVar('SKIP_SANITY_BBAPPEND_CHECK') == "1"
    enabled = e.data.getVar('ENABLE_KERNEL_DEV') == '1'
    if not enabled and not skip_check:
        bb.warn("You have included the wrlinux-kernel-dev layer, but \
ENABLE_KERNEL_DEV = '1' has not been set. See the wrlinux-kernel-dev \
README for details on enabling this layer support.")
}

