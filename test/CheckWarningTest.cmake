cmake_minimum_required(VERSION 3.5)

file(
  DOWNLOAD https://github.com/threeal/assertion-cmake/releases/download/v1.0.0/Assertion.cmake
    ${CMAKE_BINARY_DIR}/Assertion.cmake
  EXPECTED_MD5 1d8ec589d6cc15772581bf77eb3873ff)
include(${CMAKE_BINARY_DIR}/Assertion.cmake)

function(reconfigure_sample)
  cmake_parse_arguments(PARSE_ARGV 0 ARG "USE_GLOBAL;WITH_UNUSED;IGNORE_UNUSED" "" "")
  message(STATUS "Reconfiguring sample project")
  if(ARG_USE_GLOBAL)
    list(APPEND CONFIGURE_ARGS -D USE_GLOBAL=TRUE)
  endif()
  if(ARG_WITH_UNUSED)
    list(APPEND CONFIGURE_ARGS -D WITH_UNUSED=TRUE)
  endif()
  if(ARG_IGNORE_UNUSED)
    list(APPEND CONFIGURE_ARGS -D IGNORE_UNUSED=TRUE)
  endif()
  assert_execute_process(
    "${CMAKE_COMMAND}"
      -B ${CMAKE_CURRENT_LIST_DIR}/sample/build
      ${CONFIGURE_ARGS}
      --fresh
      ${CMAKE_CURRENT_LIST_DIR}/sample)
endfunction()

function(build_sample)
  cmake_parse_arguments(PARSE_ARGV 0 ARG SHOULD_FAIL "" "")
  if(ARG_SHOULD_FAIL)
    assert_execute_process(
      COMMAND "${CMAKE_COMMAND}" --build ${CMAKE_CURRENT_LIST_DIR}/sample/build
      ERROR ".*")
  else()
    assert_execute_process(
      "${CMAKE_COMMAND}" --build ${CMAKE_CURRENT_LIST_DIR}/sample/build)
  endif()
endfunction()

function("Check warning for success")
  reconfigure_sample()
  build_sample()
endfunction()

function("Check warning globally for success")
  reconfigure_sample(USE_GLOBAL)
  build_sample()
endfunction()

function("Check warning for failure")
  reconfigure_sample(WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endfunction()

function("Check warning globally for failure")
  reconfigure_sample(USE_GLOBAL WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endfunction()

function("Check warning for failure but ignored")
  reconfigure_sample(WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endfunction()

function("Check warning globally for failure but ignored")
  reconfigure_sample(USE_GLOBAL WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endfunction()

cmake_language(CALL "${TEST_COMMAND}")
