add_test(
  NAME "Testing warning check for success"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D TARGETS=correct;correct_c
      -P ${CMAKE_CURRENT_SOURCE_DIR}/BuildSample.cmake
)

add_test(
  NAME "Testing warning check for failure"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D TARGETS=incorrect;incorrect_c
      -D BUILD_SHOULD_FAIL=TRUE
      -P ${CMAKE_CURRENT_SOURCE_DIR}/BuildSample.cmake
)

add_test(
  NAME "Testing warning check with additional parameters"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D TARGETS=with_parameters;with_parameters_c
      -P ${CMAKE_CURRENT_SOURCE_DIR}/BuildSample.cmake
)
