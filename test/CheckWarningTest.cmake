cmake_minimum_required(VERSION 3.5)

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
  execute_process(
    COMMAND "${CMAKE_COMMAND}"
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
  cmake_parse_arguments(PARSE_ARGV 0 ARG SHOULD_FAIL "" "")
  message(STATUS "Building sample project")
  execute_process(
    COMMAND "${CMAKE_COMMAND}" --build ${CMAKE_CURRENT_LIST_DIR}/sample/build
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
