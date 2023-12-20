message(STATUS "Preparing for warning check testing")
file(REMOVE_RECURSE ${CMAKE_CURRENT_SOURCE_DIR}/build)
execute_process(
  COMMAND cmake ${CMAKE_CURRENT_SOURCE_DIR}/sample -B ${CMAKE_CURRENT_SOURCE_DIR}/build -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
  RESULT_VARIABLE RES
  OUTPUT_QUIET
  ERROR_VARIABLE ERR
  COMMAND_ERROR_IS_FATAL ANY
)
if(NOT ${RES} EQUAL 0)
  message(FATAL_ERROR "Failed to prepare for warning check testing: ${ERR}")
endif()

add_test(
  NAME "Testing warning check for success"
  COMMAND cmake --build ${CMAKE_CURRENT_SOURCE_DIR}/build --target correct --target correct_c
)

add_test(
  NAME "Testing warning check for failure"
  COMMAND cmake --build ${CMAKE_CURRENT_SOURCE_DIR}/build --target incorrect --target incorrect_c
)
set_tests_properties("Testing warning check for failure" PROPERTIES WILL_FAIL TRUE)

add_test(
  NAME "Testing warning check with additional parameters"
  COMMAND cmake --build ${CMAKE_CURRENT_SOURCE_DIR}/build --target with_parameters --target with_parameters_c
)
