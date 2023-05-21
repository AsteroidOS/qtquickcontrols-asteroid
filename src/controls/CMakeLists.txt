set(SRC
	src/controls_plugin.cpp
	src/application_p.cpp
	src/flatmesh.cpp
	src/icon.cpp)
set(HEADERS
	src/controls_plugin.h
	src/application_p.h
	src/flatmesh.h
	src/icon.h)

add_library(asteroidcontrolsplugin ${SRC} ${HEADERS} resources.qrc)

target_link_libraries(asteroidcontrolsplugin
	Qt5::Qml
	Qt5::Quick
	Qt5::Svg)

install(TARGETS asteroidcontrolsplugin
	DESTINATION ${INSTALL_QML_IMPORT_DIR}/org/asteroid/controls)
install(FILES qmldir
	DESTINATION ${INSTALL_QML_IMPORT_DIR}/org/asteroid/controls)
