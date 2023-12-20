if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/build)
  message(STATUS "Removing build directory")
  file(REMOVE_RECURSE ${CMAKE_CURRENT_LIST_DIR}/build)
endif()

message(STATUS "Configuring sample project")
list(APPEND CONFIGURE_ARGS -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH})
if(WITH_UNUSED)
  list(APPEND CONFIGURE_ARGS -D WITH_UNUSED=${WITH_UNUSED})
endif()
if(IGNORE_UNUSED)
  list(APPEND CONFIGURE_ARGS -D IGNORE_UNUSED=${IGNORE_UNUSED})
endif()
execute_process(
  COMMAND cmake ${CMAKE_CURRENT_LIST_DIR} -B ${CMAKE_CURRENT_LIST_DIR}/build ${CONFIGURE_ARGS}
  RESULT_VARIABLE RES
)
if(NOT ${RES} EQUAL 0)
  message(FATAL_ERROR "Failed to configure sample project")
endif()

message(STATUS "Building sample project")
execute_process(
  COMMAND cmake --build ${CMAKE_CURRENT_LIST_DIR}/build
  RESULT_VARIABLE RES
)
if(BUILD_SHOULD_FAIL)
  if(${RES} EQUAL 0)
    message(FATAL_ERROR "Sample project build should be failed")
  endif()
else()
  if(NOT ${RES} EQUAL 0)
    message(FATAL_ERROR "Failed to build sample project")
  endif()
endif()
