# We need a quick and easy way to seed the PR database without running
# a full system build.

python prpopulate_handler() {
    if d.getVar('BB_CURRENTTASK') != "package":
        return

    # Run the function from package.bbclass to update PRs
    # without the copy, the hash can be influenced
    bb.build.exec_func('package_get_auto_pr', d.createCopy())
}

addhandler prpopulate_handler
prpopulate_handler[eventmask] = "bb.event.DryRun"
