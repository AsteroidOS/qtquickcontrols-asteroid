if (NOT ASTEROID_SKIP_BUILD_SETTINGS)
	# Always include srcdir and builddir in include path
	# This saves typing ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} in about every subdir
	# since cmake 2.4.0
	set(CMAKE_INCLUDE_CURRENT_DIR ON)

	# put the include dirs which are in the source or build tree
	# before all other include dirs, so the headers in the sources
	# are preferred over the already installed ones
	# since cmake 2.4.1
	set(CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)

	# Add the src and build dir to the BUILD_INTERFACE include directories
	# of all targets. Similar to CMAKE_INCLUDE_CURRENT_DIR, but transitive.
	# Since CMake 2.8.11
	set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)

	# When a shared library changes, but its includes do not, don't relink
	# all dependencies. It is not needed.
	# Since CMake 2.8.11
	set(CMAKE_LINK_DEPENDS_NO_SHARED ON)

	# Default to shared libs, if no type is explicitly given to add_library():
	set(BUILD_SHARED_LIBS TRUE CACHE BOOL "If enabled, shared libs will be built by default, otherwise static libs")

	# Enable automoc in cmake
	# Since CMake 2.8.6
	set(CMAKE_AUTOMOC ON)

	# Enable autorcc and in cmake so qrc files get generated
	# Since CMake 3.0
	set(CMAKE_AUTORCC ON)

	set(INSTALL_QML_IMPORT_DIR "${CMAKE_INSTALL_FULL_LIBDIR}/qml" 
		CACHE PATH "Custom QML import installation directory")

	# Ensure availability of QTP0001 (https://doc.qt.io/qt-6/qt-cmake-policy-qtp0001.html)
	set(QT_MIN_VERSION "6.5.0")
endif()
