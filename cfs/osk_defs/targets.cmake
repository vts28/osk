######################################################################
# 
# Master config file for cFS target boards
#
# This file indicates the architecture and configuration of the
# target boards that will run core flight software.
#
# The following variables are defined per board, where <x> is the 
# CPU number starting with 1:
#
#  TGT<x>_NAME : the user-friendly name of the cpu.  Should be simple
#       word with no punctuation.  This MUST be specified.
#  TGT<x>_APPLIST : list of applications to build and install on the CPU.
#       These are built as dynamically-loaded applications and installed
#       as files in the non-volatile storage of the target, and loaded
#       at runtime via the startup script or commands.
#  TGT<x>_STATIC_APPLIST : list of applications to build and statically
#       link with the CFE executable.  This is similar to the "APPLIST"
#       except the application is built with STATIC linkage, and it is
#       included directly when linking the CFE core executable itself.
#       No separate application file is generated for these apps. 
#  TGT<x>_STATIC_SYMLIST : list of symbols to include in the OSAL static
#       symbol lookup table.  Each entry is a comma-separated pair containing
#       the symbol name and virtual module/app name, such as   
#           My_C_Function_Name,MY_APP
#       The first item must be a publicly-exposed C symbol name available to
#       the linker at static link time, generally the entry point/main function
#       of the a module or library (see STATIC_APPLIST).  The second item is the
#       module name that should match the name used in the CFE startup script 
#       (4th parameter).
#       IMPORTANT:  For this to work, the OS_STATIC_LOADER configuration option 
#       must be specified in the osconfig.h for that CPU.
#  TGT<x>_PSP_MODULELIST : additional PSP "modules" to link into the
#       CFE executable for this target.  These can be device drivers or
#       other bits of modular PSP functionality that provide I/O or other
#       low level functions.
#  TGT<x>_FILELIST : list of extra files to copy onto the target.  No
#       modifications of the file will be made.  In order to differentiate
#       between different versions of files with the same name, priority
#       will be given to a file named <cpuname>_<filename> to be installed
#       as simply <filename> on that cpu (prefix will be removed).  These
#       files are intended to be copied to the non-volatile storage on the
#       target for use during runtime.
#  TGT<x>_EMBED_FILELIST : list of extra files which are to be converted
#       into data arrays and linked with/embedded into the CFE executable, 
#       so the content of the files can be available at runtime on systems
#       that do not have run time non-volatile storage.  The format of each
#       list entry is a comma-separated pair of variable and file name:
#            VARIABLE_NAME,FILE_NAME
#       The binary contents of the file will subsequently be available as:
#            extern const char VARIABLE_NAME_DATA[] and 
#            extern const unsigned long VARIABLE_NAME_SIZE
#       The same prefix-based filename mapping as used on FILELIST is also
#       employed here, allowing CPU-specific data files to be used. 
#  TGT<x>_SYSTEM : the toolchain to use for building all code.  This
#       will map to a CMake toolchain file called "toolchain-<ZZZ>"
#       If not specified then it will default to "cpu<x>" so that
#       each CPU will have a dedicated toolchain file and no objects
#       will be shared across CPUs.  
#       Otherwise any code built using the same toolchain may be 
#       copied to multiple CPUs for more efficient builds.
#  TGT<x>_PLATFORM : configuration for the CFE core to use for this
#       cpu.  This determines the cfe_platform_cfg.h to use during the
#       build.  Multiple files/components may be concatenated together
#       allowing the config to be generated in a modular fashion.  If 
#       not specified then it will be assumed as "default <cpuname>".
# 

# The MISSION_NAME will be compiled into the target build data structure
# as well as being passed to "git describe" to filter the tags when building
# the version string.
SET(MISSION_NAME "OpenSatKit")

# SPACECRAFT_ID gets compiled into the build data structure and the PSP may use it.
# should be an integer.
SET(SPACECRAFT_ID 42)

# UI_INSTALL_SUBDIR indicates where the UI data files (included in some apps) should
# be copied during the install process.
SET(UI_INSTALL_SUBDIR "host/ui")

# FT_INSTALL_SUBDIR indicates where the black box test data files (lua scripts) should
# be copied during the install process.
SET(FT_INSTALL_SUBDIR "host/functional-test")

# Each target board can have its own HW arch selection and set of included apps
SET(TGT1_NAME cpu1) 

# Release: 
#   Not all of the apps built are loaded by cfe_es_startup.scr  
#      HC & HSIM are needed to build LC & SC default tables
#      Other apps such as osk_c_demo are used for the "app store" example and their object files need to be built 
SET(TGT1_APPLIST cfs_lib expat_lib osk_c_fw osk_cpp_fw osk_42_lib kit_ci kit_sch kit_to cs ds fm hs lc md mm sc hk tftp cf i42 f42 isim bm hc hsim filemgr osk_c_demo osk_cpp_demo dosd dosi)
# Development:
#   Comment out Release TGT1_APPLIST and modify one of these for your your needs.
#   SET(TGT1_APPLIST cfs_lib expat_lib osk_c_fw osk_cpp_fw osk_42_lib kit_ci kit_sch kit_to osk_c_demo osk_cpp_demo filemgr)
#   SET(TGT1_STATIC_APPLIST cfs_lib osk_c_fw osk_c_demo osk_cpp_fw osk_cpp_demo)
#   SET(TGT1_APPLIST cfs_lib osk_c_fw osk_cpp_fw osk_c_demo osk_cpp_demo)
#   Other OSK apps available to build: bm osk_demo_app hs cf sbn cpp_demo_app

SET(TGT1_FILELIST cfe_es_startup.scr osk_to_pkt_tbl.json osk_sch_msg_tbl.json osk_sch_sch_tbl.json osk_c_demo_tbl.json osk_c_demo_tbl.scanf osk_c_demo_tbl.xml osk_cpp_tbl.json f42_ctrl_tbl.json isim_tbl.json filemgr_ini.json)

#~set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")

# CPU2/3 are duplicates of CPU1.  These are not built by default anymore but are
# commented out to serve as an example of how one would configure multiple cpus.
#SET(TGT2_NAME cpu2)
#SET(TGT2_APPLIST sample_app ci_lab to_lab sch_lab)
#SET(TGT2_FILELIST cfe_es_startup.scr)

#SET(TGT3_NAME cpu3)
#SET(TGT3_APPLIST sample_app ci_lab to_lab sch_lab)
#SET(TGT3_FILELIST cfe_es_startup.scr)
