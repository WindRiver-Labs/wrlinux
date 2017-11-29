do_populate_sdk[postfuncs] =+ "kernel_sdkpostprocess"
python kernel_sdkpostprocess () {

    import os, subprocess

    sdk_output =         d.getVar('SDK_OUTPUT', True) or ""
    sdk_target_sysroot = d.getVar('SDKTARGETSYSROOT', True) or ""
    cross_tool_prefix =  d.getVar('TARGET_RAW_PREFIX', True) or ""

    repack_sdk = 0

    bb.note( "kernel SDK: start" )

    kernel_src_base = sdk_output + sdk_target_sysroot + "/usr/src/kernel"

    if os.path.exists(kernel_src_base):
        bb.note( "kernel SDK: kernel source found, creating scripts" )
        makecmd = "cd %s; pwd; make CROSS_COMPILE=" + cross_tool_prefix + " scripts"
        cmd = d.expand(makecmd % kernel_src_base )
        ret, result = subprocess.getstatusoutput("%s" % cmd)
        bb.note( "%s" % result )
        repack_sdk = 1

    if repack_sdk:
        bb.build.exec_func('tar_sdk', d)
        bb.build.exec_func('create_shar', d)

    bb.note( "kernel SDK: done" )
}
