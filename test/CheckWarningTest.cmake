# Matches everything if not defined
if(NOT TEST_MATCHES)
  set(TEST_MATCHES ".*")
endif()

function(reconfigure_sample)
  cmake_parse_arguments(ARG "USE_GLOBAL;WITH_UNUSED;IGNORE_UNUSED" "" "" ${ARGN})
  message(STATUS "Configuring sample project")
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
    ERROR_VARIABLE ERR
    RESULT_VARIABLE RES
  )
  if(NOT ${RES} EQUAL 0)
    message(FATAL_ERROR "Failed to configure sample project: ${ERR}")
  endif()
endfunction()

function(build_sample)
  cmake_parse_arguments(ARG SHOULD_FAIL "" "" ${ARGN})
  message(STATUS "Building sample project")
  execute_process(
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_CURRENT_LIST_DIR}/sample/build
    ERROR_VARIABLE ERR
    RESULT_VARIABLE RES
  )
  if(ARG_SHOULD_FAIL)
    if(${RES} EQUAL 0)
      message(FATAL_ERROR "Sample project build should be failed")
    endif()
  else()
    if(NOT ${RES} EQUAL 0)
      message(FATAL_ERROR "Failed to build sample project: ${ERR}")
    endif()
  endif()
endfunction()

if("Testing warning check for success" MATCHES ${TEST_MATCHES})
  reconfigure_sample()
  build_sample()
endif()

if("Testing global warning check for success" MATCHES ${TEST_MATCHES})
  reconfigure_sample(USE_GLOBAL)
  build_sample()
endif()

if("Testing warning check for failure" MATCHES ${TEST_MATCHES})
  reconfigure_sample(WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endif()

if("Testing global warning check for failure" MATCHES ${TEST_MATCHES})
  reconfigure_sample(USE_GLOBAL WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endif()

if("Testing warning check with failure but ignored" MATCHES ${TEST_MATCHES})
  reconfigure_sample(WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endif()

if("Testing global warning check with failure but ignored" MATCHES ${TEST_MATCHES})
  reconfigure_sample(USE_GLOBAL WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endif()
