# This handler has the ability to clear KERNEL_FEATURES, but should
# be used carefully since clearing KERNEL_FEATURES breaks the binding
# between layers and what the kernel provides
python kernfeatures_handler () {
    if not isinstance(e, bb.event.RecipeParsed):
        return

    kernfeatures_clear = e.data.getVar( 'KERNEL_FEATURES_CLEAR', False )
    if kernfeatures_clear:
          e.data.setVar('KERNEL_FEATURES', "")

    kernfeatures_force = e.data.getVar( 'KERNEL_FEATURES_FORCE', False )
    if kernfeatures_force:
          e.data.setVar('KERNEL_FEATURES', kernfeatures_force )
}
addhandler kernfeatures_handler
