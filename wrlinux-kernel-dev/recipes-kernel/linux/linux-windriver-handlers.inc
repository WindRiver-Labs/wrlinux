# This handler has the ability to clear KERNEL_FEATURES, but should
# be used carefully since clearing KERNEL_FEATURES breaks the binding
# between layers and what the kernel provides
python __anonymous () {
    kernfeatures_clear = d.getVar( 'KERNEL_FEATURES_CLEAR', False )
    if kernfeatures_clear:
          d.setVar('KERNEL_FEATURES', "")

    kernfeatures_force = d.getVar( 'KERNEL_FEATURES_FORCE', False )
    if kernfeatures_force:
          d.setVar('KERNEL_FEATURES', kernfeatures_force )
}
