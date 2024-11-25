# Try to find mlite6
# Once done this will define
# MLITE6_FOUND - System has mlite6
# MLITE6_INCLUDE_DIRS - The mlite6 include directories
# MLITE6_LIBRARIES - The libraries needed to use mlite6
# MLITE6_DEFINITIONS - Compiler switches required for using mlite6

find_package(PkgConfig REQUIRED)
pkg_check_modules(PC_Mlite6 QUIET mlite6)
set(Mlite6_DEFINITIONS ${PC_Mlite6_CFLAGS_OTHER})

find_path(Mlite6_INCLUDE_DIRS
	NAMES mlite-global.h
	PATH_SUFFIXES mlite6
	PATHS ${PC_Mlite6_INCLUDEDIR} ${PC_Mlite6_INCLUDE_DIRS})

find_library(Mlite6_LIBRARIES
	NAMES mlite6
	PATHS ${PC_Mlite6_LIBDIR} ${PC_Mlite6_LIBRARY_DIRS})

set(Mlite6_VERSION ${PC_Mlite6_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Mlite6
	FOUND_VAR
		Mlite6_FOUND
	REQUIRED_VARS
		Mlite6_LIBRARIES
		Mlite6_INCLUDE_DIRS
	VERSION_VAR
		Mlite6_VERSION)

mark_as_advanced(Mlite6_INCLUDE_DIR Mlite6_LIBRARY Mlite6_VERSION)

if(Mlite6_FOUND AND NOT TARGET Mlite6::Mlite6)
	add_library(Mlite6::Mlite6 UNKNOWN IMPORTED)
	set_target_properties(Mlite6::Mlite6 PROPERTIES
		IMPORTED_LOCATION "${Mlite6_LIBRARIES}"
		INTERFACE_INCLUDE_DIRECTORIES "${Mlite6_INCLUDE_DIRS}")
endif()
