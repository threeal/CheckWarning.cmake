function(add_cmake_test FILE)
  foreach(NAME ${ARGN})
    add_test(
      NAME ${NAME}
      COMMAND ${CMAKE_COMMAND}
        -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
        -D TEST_MATCHES=^${NAME}$
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
