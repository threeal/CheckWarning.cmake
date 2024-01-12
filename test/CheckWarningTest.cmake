add_test(
  NAME "Testing warning check for success"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -P ${CMAKE_CURRENT_LIST_DIR}/sample/Build.cmake
)

add_test(
  NAME "Testing global warning check for success"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D USE_GLOBAL=TRUE
      -P ${CMAKE_CURRENT_LIST_DIR}/sample/Build.cmake
)

add_test(
  NAME "Testing warning check for failure"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D WITH_UNUSED=TRUE
      -D BUILD_SHOULD_FAIL=TRUE
      -P ${CMAKE_CURRENT_LIST_DIR}/sample/Build.cmake
)

add_test(
  NAME "Testing global warning check for failure"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D USE_GLOBAL=TRUE
      -D WITH_UNUSED=TRUE
      -D BUILD_SHOULD_FAIL=TRUE
      -P ${CMAKE_CURRENT_LIST_DIR}/sample/Build.cmake
)

add_test(
  NAME "Testing warning check with failure but ignored"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D WITH_UNUSED=TRUE
      -D IGNORE_UNUSED=TRUE
      -P ${CMAKE_CURRENT_LIST_DIR}/sample/Build.cmake
)

add_test(
  NAME "Testing global warning check with failure but ignored"
  COMMAND
    cmake
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      -D USE_GLOBAL=TRUE
      -D WITH_UNUSED=TRUE
      -D IGNORE_UNUSED=TRUE
      -P ${CMAKE_CURRENT_LIST_DIR}/sample/Build.cmake
)
