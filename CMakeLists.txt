cmake_minimum_required(VERSION 3.27.0)

project(qml-asteroid
	VERSION 2.0.0
	DESCRIPTION "QML components, styles and demos for AsteroidOS")

find_package(ECM REQUIRED NO_MODULE)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)

option(WITH_ASTEROIDAPP "Build the AsteroidApp class" ON)
option(WITH_MAPPLAUNCHERD "Build the AsteroidApp class with Mapplauncherd booster support" ON)
option(WITH_CMAKE_MODULES "Install AsteroidOS CMake modules" ON)

include(FeatureSummary)
include(GNUInstallDirs)
include(ECMFindQmlModule)
include(ECMGeneratePkgConfigFile)
include(AsteroidCMakeSettings)

set(ASTEROID_MODULES_INSTALL_DIR ${CMAKE_INSTALL_DATADIR}/asteroidapp/cmake)

find_package(Qt6 ${QT_MIN_VERSION} COMPONENTS DBus Qml Quick Svg ShaderTools REQUIRED)
if (WITH_ASTEROIDAPP)
    find_package(Mlite6 MODULE REQUIRED)
    if (WITH_MAPPLAUNCHERD)
        find_package(Mapplauncherd_qt6 MODULE REQUIRED)
    endif()
endif()

ecm_find_qmlmodule(QtQuick.VirtualKeyboard 2.1)

if (WITH_CMAKE_MODULES)
# Install CMake modules
    file(GLOB installAsteroidModuleFiles LIST_DIRECTORIES FALSE ${CMAKE_SOURCE_DIR}/cmake/*[^~])
    install(FILES ${installAsteroidModuleFiles} DESTINATION ${ASTEROID_MODULES_INSTALL_DIR})
else()
    get_target_property(REAL_QMAKE_EXECUTABLE Qt::qmake IMPORTED_LOCATION)

    if (NOT QT_INSTALL_QML)
        execute_process(COMMAND "${REAL_QMAKE_EXECUTABLE}" -query QT_INSTALL_QML
                        OUTPUT_VARIABLE QT_INSTALL_QML
                        ERROR_QUIET OUTPUT_STRIP_TRAILING_WHITESPACE)
    endif()
    set(INSTALL_QML_IMPORT_DIR ${QT_INSTALL_QML})
endif()

add_subdirectory(src)

if (WITH_ASTEROIDAPP)
    install(PROGRAMS generate-desktop.sh
            DESTINATION ${CMAKE_INSTALL_BINDIR}
            RENAME asteroid-generate-desktop)
endif() 

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
