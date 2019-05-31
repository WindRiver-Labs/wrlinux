#
# 
# e.g.
# In the depreated old recipe, write as follows:
# inherit dprecate
# ALTERNATIVE_NEW_RECIPE = "new_recipe_name"
#

ALTERNATIVE_NEW_RECIPE ?= ""

python do_warn_deprecate() {
    pn = d.getVar('BPN')
    alternative_new_recipe = d.getVar('ALTERNATIVE_NEW_RECIPE')
    if alternative_new_recipe:
        bb.warn("Deprecated recipe %s, use %s instead" % (pn, alternative_new_recipe))
    else:
        bb.warn("Deprecated recipe %s")
}

do_warn_deprecate[nostamp] = "1"

addtask warn_deprecate before do_build
