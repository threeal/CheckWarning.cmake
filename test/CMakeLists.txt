add_test(
  NAME CheckWarningTest.cmake
  COMMAND "${CMAKE_COMMAND}"
    -P ${CMAKE_CURRENT_SOURCE_DIR}/CheckWarningTest.cmake)
