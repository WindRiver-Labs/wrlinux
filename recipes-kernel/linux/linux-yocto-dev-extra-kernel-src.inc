FIX_GCC_PLUGINS_KERNEL_FILES := "${THISDIR}/linux-yocto:"                           
FIX_GCC_PLUGINS_KERNEL_SRC_URI = " \                                               
    file://0001-gcc-plugins-use-HOSTCXX-to-detect-the-designated-ini.patch \                          
"                                                                                  
                                                                                   
TEMP_KERNEL_FILES ?= ""                                                            
TEMP_KERNEL_SRC_URI ?= ""                                                          
TEMP_KERNEL_FILES_ti-am335x = "${FIX_GCC_PLUGINS_KERNEL_FILES}"                    
TEMP_KERNEL_SRC_URI_ti-am335x = "${FIX_GCC_PLUGINS_KERNEL_SRC_URI}"                
TEMP_KERNEL_FILES_xilinx-zynq = "${FIX_GCC_PLUGINS_KERNEL_FILES}"                    
TEMP_KERNEL_SRC_URI_xilinx-zynq = "${FIX_GCC_PLUGINS_KERNEL_SRC_URI}"                
TEMP_KERNEL_FILES_qemuarm = "${FIX_GCC_PLUGINS_KERNEL_FILES}"                      
TEMP_KERNEL_SRC_URI_qemuarm = "${FIX_GCC_PLUGINS_KERNEL_SRC_URI}"                  
TEMP_KERNEL_FILES_qemuarmv5 = "${FIX_GCC_PLUGINS_KERNEL_FILES}"                    
TEMP_KERNEL_SRC_URI_qemuarmv5 = "${FIX_GCC_PLUGINS_KERNEL_SRC_URI}"                
                                                                                   
EXTRA_KERNEL_FILES =. "${TEMP_KERNEL_FILES}"                                                                                                
EXTRA_KERNEL_SRC_URI += "${TEMP_KERNEL_SRC_URI}"                                   
