# Matches everything if not defined
if(NOT TEST_MATCHES)
  set(TEST_MATCHES ".*")
endif()

function(reconfigure_sample)
  cmake_parse_arguments(ARG "USE_GLOBAL;WITH_UNUSED;IGNORE_UNUSED" "" "" ${ARGN})
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
  execute_process(
    COMMAND ${CMAKE_COMMAND}
      -B ${CMAKE_CURRENT_LIST_DIR}/sample/build
      -D CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}
      ${CONFIGURE_ARGS}
      --fresh
      ${CMAKE_CURRENT_LIST_DIR}/sample
    RESULT_VARIABLE RES
  )
  if(NOT RES EQUAL 0)
    message(FATAL_ERROR "Failed to reconfigure sample project")
  endif()
endfunction()

function(build_sample)
  cmake_parse_arguments(ARG SHOULD_FAIL "" "" ${ARGN})
  message(STATUS "Building sample project")
  execute_process(
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_CURRENT_LIST_DIR}/sample/build
    RESULT_VARIABLE RES
  )
  if(ARG_SHOULD_FAIL)
    if(RES EQUAL 0)
      message(FATAL_ERROR "Sample project build should be failed")
    endif()
  else()
    if(NOT RES EQUAL 0)
      message(FATAL_ERROR "Failed to build sample project")
    endif()
  endif()
endfunction()

set(TEST_COUNT 0)

if("Check warning for success" MATCHES ${TEST_MATCHES})
  math(EXPR TEST_COUNT "${TEST_COUNT} + 1")
  reconfigure_sample()
  build_sample()
endif()

if("Check warning globally for success" MATCHES ${TEST_MATCHES})
  math(EXPR TEST_COUNT "${TEST_COUNT} + 1")
  reconfigure_sample(USE_GLOBAL)
  build_sample()
endif()

if("Check warning for failure" MATCHES ${TEST_MATCHES})
  math(EXPR TEST_COUNT "${TEST_COUNT} + 1")
  reconfigure_sample(WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endif()

if("Check warning globally for failure" MATCHES ${TEST_MATCHES})
  math(EXPR TEST_COUNT "${TEST_COUNT} + 1")
  reconfigure_sample(USE_GLOBAL WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endif()

if("Check warning for failure but ignored" MATCHES ${TEST_MATCHES})
  math(EXPR TEST_COUNT "${TEST_COUNT} + 1")
  reconfigure_sample(WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endif()

if("Check warning globally for failure but ignored" MATCHES ${TEST_MATCHES})
  math(EXPR TEST_COUNT "${TEST_COUNT} + 1")
  reconfigure_sample(USE_GLOBAL WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endif()

if(TEST_COUNT LESS_EQUAL 0)
  message(FATAL_ERROR "Nothing to test with: ${TEST_MATCHES}")
endif()
