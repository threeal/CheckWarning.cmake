function(add_cmake_test FILE)
  math(EXPR STOP "${ARGC} - 1")
  foreach(I RANGE 1 "${STOP}")
    add_test(
      NAME "${ARGV${I}}"
      COMMAND "${CMAKE_COMMAND}"
        -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
        -D "TEST_COMMAND=${ARGV${I}}"
        -P ${CMAKE_CURRENT_SOURCE_DIR}/${FILE}
    )
  endforeach()
endfunction()

add_cmake_test(
  CheckWarningTest.cmake
  "Check warning for success"
  "Check warning globally for success"
  "Check warning for failure"
  "Check warning globally for failure"
  "Check warning for failure but ignored"
  "Check warning globally for failure but ignored"
)
