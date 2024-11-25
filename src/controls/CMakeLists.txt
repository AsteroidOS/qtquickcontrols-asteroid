set(SRC
	src/controls_plugin.cpp
	src/application_p.cpp
	src/flatmesh.cpp
	src/flatmeshnode.cpp
	src/icon.cpp)
set(HEADERS
	src/controls_plugin.h
	src/application_p.h
	src/flatmesh.h
	src/flatmeshnode.h
	src/icon.h)

set(controls
        Application
        BorderGestureArea
        CircularSpinner
        Dims
        HandWritingKeyboard
        HighlightBar
        IconButton
        Indicator
        IntSelector
        Label
        LabeledActionButton
        LabeledSwitch
        LayerStack
        ListItem
        Marquee
        PageDot
        PageHeader
        SegmentedArc
        Spinner
        SpinnerDelegate
        StatusPage
        Switch
        TextArea
        TextBase
        TextField
)
foreach(control ${controls})
    list(APPEND controls-qml "qml/${control}.qml")
endforeach()

set_source_files_properties(qml/Dims.qml
	PROPERTIES QT_QML_SINGLETON_TYPE TRUE)

qt_add_qml_module(asteroidcontrolsplugin
	URI org.asteroid.controls
	VERSION 1.0
	PLUGIN_TARGET asteroidcontrolsplugin
	NO_GENERATE_PLUGIN_SOURCE
	#NO_PLUGIN_OPTIONAL
	QML_FILES
		${controls-qml}
	#ENABLE_TYPE_COMPILER
	SOURCES
		${SRC} ${HEADERS}
)

# TODO: drop debug once AOT produces less warnings etc
set_target_properties(asteroidcontrolsplugin PROPERTIES QT_QMLCACHEGEN_ARGUMENTS "--verbose")

qt6_add_shaders(asteroidcontrolsplugin "asteroidcontrolsplugin_shaders"
    PREFIX "/org/asteroid/controls/"
    FILES "qml/Spinner.frag"
    BATCHABLE
    PRECOMPILE
    OPTIMIZED)

target_link_libraries(asteroidcontrolsplugin
	PUBLIC
		#Qt::Qml
		Qt::Quick # src/{application_p,flatmesh{,node},icon}.*
	PRIVATE
		Qt::Svg # src/icon.cpp
)

set(controls-docs "$<LIST:TRANSFORM,$<LIST:TRANSFORM,$<LOWER_CASE:${controls}>,PREPEND,qml->,APPEND,.html>")
set(doc-dir "${CMAKE_BINARY_DIR}/doc/html")
set(full-controls-docs "$<LIST:TRANSFORM,${controls-docs},PREPEND,${doc-dir}>")

add_custom_target(
    doc
    DEPENDS "${full-controls-docs}"
)

add_custom_command(
    OUTPUT  "${full-controls-docs}"
    COMMAND "qdoc" "-indexdir" "/usr/share/doc/qt5" "-outputdir" "${doc-dir}" "${CMAKE_CURRENT_SOURCE_DIR}/doc/asteroid_controls.qdocconf" 
    COMMENT "Generating HTML format Reference documentation..." VERBATIM
)

install(TARGETS asteroidcontrolsplugin
	DESTINATION ${INSTALL_QML_IMPORT_DIR}/org/asteroid/controls)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/qmldir
	DESTINATION ${INSTALL_QML_IMPORT_DIR}/org/asteroid/controls)
