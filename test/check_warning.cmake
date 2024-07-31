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

section("it should check warning for success")
  reconfigure_sample()
  build_sample()
endsection()

section("it should check warning globally for success")
  reconfigure_sample(USE_GLOBAL)
  build_sample()
endsection()

section("it should check warning for failure")
  reconfigure_sample(WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endsection()

section("it should check warning globally for failure")
  reconfigure_sample(USE_GLOBAL WITH_UNUSED)
  build_sample(SHOULD_FAIL)
endsection()

section("it should check warning for failure but ignored")
  reconfigure_sample(WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endsection()

section("it should check warning globally for failure but ignored")
  reconfigure_sample(USE_GLOBAL WITH_UNUSED IGNORE_UNUSED)
  build_sample()
endsection()
