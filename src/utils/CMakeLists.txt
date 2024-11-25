set(SRC
	src/deviceinfo.cpp
	src/fileinfo.cpp
	src/bluetoothstatus.cpp)
set(HEADERS
	src/deviceinfo.h
	src/fileinfo.h
	src/bluetoothstatus.h)

# TODO: ensure FileInfo 1.0 (singleton) & BluetoothStatus 1.0 (normal) QML classes work
qt_add_qml_module(asteroidutilsplugin
	URI org.asteroid.utils
	VERSION 1.0
	PLUGIN_TARGET asteroidutilsplugin
	#NO_PLUGIN_OPTIONAL
	SOURCES
		${SRC} ${HEADERS}
)

target_include_directories(asteroidutilsplugin PRIVATE src)

target_link_libraries(asteroidutilsplugin
	#PUBLIC
	#	Qt::Qml
	#	Qt::Quick
	PRIVATE
		Qt::DBus # bluetoothstatus
)

install(TARGETS asteroidutilsplugin
	DESTINATION ${INSTALL_QML_IMPORT_DIR}/org/asteroid/utils)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/qmldir
    DESTINATION ${INSTALL_QML_IMPORT_DIR}/org/asteroid/utils)
