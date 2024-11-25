# Try to find qdeclarative6-boostable
# Once done this will define
# MAPPLAUNCHERD_QT6_FOUND - System has qdeclarative
# MAPPLAUNCHERD_QT6_INCLUDE_DIRS - The qdeclarative include directories
# MAPPLAUNCHERD_QT6_LIBRARIES - The libraries needed to use qdeclarative
# MAPPLAUNCHERD_QT6_DEFINITIONS - Compiler switches required for using qdeclarative

find_package(PkgConfig REQUIRED)
pkg_check_modules(PC_Mapplauncherd_qt6 QUIET qdeclarative6-boostable)
set(Mapplauncherd_qt6_DEFINITIONS ${PC_Mapplauncherd_qt6_CFLAGS_OTHER})

find_path(Mapplauncherd_qt6_INCLUDE_DIRS
	NAMES mdeclarativecache.h
	PATH_SUFFIXES mdeclarativecache6
	PATHS ${PC_Mapplauncherd_qt6_INCLUDEDIR} ${PC_Mapplauncherd_qt6_INCLUDE_DIRS})

find_library(Mapplauncherd_qt6_LIBRARIES
	NAMES mdeclarativecache6
	PATHS ${PC_Mapplauncherd_qt6_LIBDIR} ${PC_Mapplauncherd_qt6_LIBRARY_DIRS})

set(Mapplauncherd_qt6_VERSION ${PC_Mapplauncherd_qt6_VERSION})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Mapplauncherd_qt6
	FOUND_VAR
		Mapplauncherd_qt6_FOUND
	REQUIRED_VARS
		Mapplauncherd_qt6_LIBRARIES
		Mapplauncherd_qt6_INCLUDE_DIRS
	VERSION_VAR
		Mapplauncherd_qt6_VERSION)

mark_as_advanced(Mapplauncherd_qt6_INCLUDE_DIR Mapplauncherd_qt6_LIBRARY Mapplauncherd_qt6_VERSION)

if(Mapplauncherd_qt6_FOUND AND NOT TARGET Mapplauncherd_qt6::Mapplauncherd_qt6)
	add_library(Mapplauncherd_qt6::Mapplauncherd_qt6 UNKNOWN IMPORTED)
	set_target_properties(Mapplauncherd_qt6::Mapplauncherd_qt6 PROPERTIES
		IMPORTED_LOCATION "${Mapplauncherd_qt6_LIBRARIES}"
		INTERFACE_INCLUDE_DIRECTORIES "${Mapplauncherd_qt6_INCLUDE_DIRS}")
endif()
