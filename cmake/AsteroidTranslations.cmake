function(BUILD_TRANSLATIONS directory)
	if(TARGET build-translations)
		message(WARNING "The build_translations function was already called")
		return()
	endif()

	find_package(Qt6LinguistTools REQUIRED)

	file(GLOB LANGUAGE_FILES_TS ${directory}/*.ts)
	#set_source_files_properties(${LANGUAGE_FILES_TS} PROPERTIES OUTPUT_LOCATION "i18n")
	qt_add_translation(LANGUAGE_FILES_QM ${LANGUAGE_FILES_TS} OPTIONS "-idbased")
	add_custom_target(build-translations ALL
		COMMENT "Building translations in ${director}..."
		DEPENDS ${LANGUAGE_FILES_QM})

	install(FILES ${LANGUAGE_FILES_QM}
		DESTINATION ${CMAKE_INSTALL_DATADIR}/translations)
endfunction()

function(GENERATE_DESKTOP src_directory application_name)
	find_program(generate_desktop_executable
		NAMES asteroid-generate-desktop)

	set(OUTPUT_DESKTOP_FILE ${CMAKE_BINARY_DIR}/${application_name}.desktop)
	execute_process(
		COMMAND ${generate_desktop_executable} ${src_directory} ${application_name} ${OUTPUT_DESKTOP_FILE})

	install(FILES ${OUTPUT_DESKTOP_FILE}
		DESTINATION ${CMAKE_INSTALL_DATADIR}/applications)
endfunction()
