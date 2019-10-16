

# With -O0 optimization we blow up linking/relocating.
#
DEBUG_OPTIMIZATION_append_powerpc = " -O1"
DEBUG_OPTIMIZATION_append_mips = " -O1"
DEBUG_OPTIMIZATION_append_aarch64 = " -O1"
# Blow up linking/relocating error.
PROFILING_OPTIMIZATION_remove_powerpc = "-fno-omit-frame-pointer"
