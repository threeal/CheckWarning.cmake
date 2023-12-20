message(STATUS "Configuring sample project")
set(SAMPLE_DIR ${CMAKE_CURRENT_LIST_DIR}/sample)
execute_process(
  COMMAND cmake ${SAMPLE_DIR} -B ${SAMPLE_DIR}/build -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
  RESULT_VARIABLE RES
)
if(NOT ${RES} EQUAL 0)
  message(FATAL_ERROR "Failed to configure sample project")
endif()

message(STATUS "Building project")
foreach(TARGET ${TARGETS})
  list(APPEND BUILD_ARGS --target ${TARGET})
endforeach()
execute_process(
  COMMAND cmake --build ${SAMPLE_DIR}/build ${BUILD_ARGS}
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
