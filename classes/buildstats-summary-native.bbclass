# Summarize sstate usage at the end of the build
python buildstats_summary () {
    import collections
    import os.path

    bsdir = e.data.expand("${BUILDSTATS_BASE}/${BUILDNAME}")
    if not os.path.exists(bsdir):
        return

    sstatetasks = (e.data.getVar('SSTATETASKS') or '').split()
    built = collections.defaultdict(lambda: [set(), set(), set(), set()])
    for pf in os.listdir(bsdir):
        taskdir = os.path.join(bsdir, pf)
        if not os.path.isdir(taskdir):
            continue

        tasks = os.listdir(taskdir)
        for t in sstatetasks:
            target_source, native_source, native_sstate, target_sstate = built[t]
            if t in tasks and "-native" in pf:
                native_source.add(pf)
            elif t in tasks:
                target_source.add(pf)
            elif t + '_setscene' in tasks and "-native" in pf:
                native_sstate.add(pf)
            elif t + '_setscene' in tasks:
                target_sstate.add(pf)

    header_printed = False
    for t in sstatetasks:
        target_source, native_source, native_sstate, target_sstate = built[t]
        if target_source | native_source | native_sstate | target_sstate:
            if not header_printed:
                header_printed = True
                bb.note("Build completion summary:")
            
            bb.note("{0}:".format(t))

            target_sstate_count = len(target_sstate)
            native_sstate_count = len(native_sstate)
            target_source_count = len(target_source)
            native_source_count = len(native_source)
            bb.note("target from sstate {0}, native from sstate {1}, target from source {2}, native from source {3}".format(target_sstate_count, native_sstate_count, target_source_count, native_source_count))
            total_source_count = target_source_count + native_source_count
            total_sstate_count = target_sstate_count + native_sstate_count
            total_native_count = native_source_count + native_sstate_count
            total_target_count = target_source_count + target_sstate_count
            total_count = total_source_count + total_sstate_count
            bb.note("total from source {0}, total from sstate {1}, total native {2}, total target {3}, sum total {4}".format(total_source_count, total_sstate_count, total_native_count, total_target_count, total_count))

            #do_package_qa, do_packagedata, and do_package_write_rpm won't have native sstate, so declare them as 0% reuse 
            if native_sstate_count == 0:
                bb.note("native from source {0} of {1} (0% sstate reuse), from source {2} of {3} ({4:.1f}% sstate reuse), {5} total".format(native_source_count, total_native_count, target_source_count, total_target_count, round(100 * target_sstate_count / total_target_count, 1), total_count))
            # Avoid division-by-zero if only native packages were built
            elif total_target_count == 0:
                bb.note("native from source {0} of {1} ({2:.1f}% sstate reuse), from source {3} of {4} (0% sstate reuse), {5} total".format(native_source_count, total_native_count, round(100 * native_sstate_count / total_native_count, 1), target_source_count, total_target_count, total_count))
            else:
                bb.note("native from source {0} of {1} ({2:.1f}% sstate reuse), from source {3} of {4} ({5:.1f}% sstate reuse), {6} total".format(native_source_count, total_native_count, round(100 * native_sstate_count / total_native_count, 1), target_source_count, total_target_count, round(100 * target_sstate_count / total_target_count, 1), total_count))
}
addhandler buildstats_summary
buildstats_summary[eventmask] = "bb.event.BuildCompleted"
