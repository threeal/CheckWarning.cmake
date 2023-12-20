add_test(
  NAME "Testing warning check for success"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -P ${CMAKE_CURRENT_SOURCE_DIR}/BuildSample.cmake
)

add_test(
  NAME "Testing warning check for failure"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D WITH_UNUSED=TRUE
      -D BUILD_SHOULD_FAIL=TRUE
      -P ${CMAKE_CURRENT_SOURCE_DIR}/BuildSample.cmake
)

add_test(
  NAME "Testing warning check with failure but ignored"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D WITH_UNUSED=TRUE
      -D IGNORE_UNUSED=TRUE
      -P ${CMAKE_CURRENT_SOURCE_DIR}/BuildSample.cmake
)
