include(Assertion RESULT_VARIABLE ASSERTION_LIST_FILE)
include(CheckWarning RESULT_VARIABLE CHECK_WARNING_LIST_FILE)

# This variable contains the header source files for the sample project's
# `CMakeLists.txt` file.
set(PROJECT_CMAKELISTS_HEADER_SRC
  "cmake_minimum_required(VERSION 3.5)\n"
  "project(Sample LANGUAGES CXX)\n"
  "\n"
  "option(TREAT_WARNINGS_AS_ERRORS \"\" ON)\n"
  "if(TREAT_WARNINGS_AS_ERRORS)\n"
  "  set(WARNING_OPTIONS TREAT_WARNINGS_AS_ERRORS)\n"
  "endif()\n"
  "\n"
  "include(${ASSERTION_LIST_FILE})\n"
  "include(${CHECK_WARNING_LIST_FILE})\n"
  "\n"
  "get_warning_flags(WARNING_FLAGS \${WARNING_OPTIONS})\n")

# Asserts configuring the sample project build.
#
# assert_configure_project([NO_TREAT_WARNINGS_AS_ERRORS])
#
# This function asserts whether the sample project build can be configured
# successfully. If the `NO_TREAT_WARNINGS_AS_ERRORS` option is specified, it
# configures the build without treating warnings as errors.
function(assert_configure_project)
  cmake_parse_arguments(PARSE_ARGV 0 ARG NO_TREAT_WARNINGS_AS_ERRORS "" "")
  if(DEFINED CMAKE_CXX_COMPILER)
    message("Compiling with: ${CMAKE_CXX_COMPILER}")
    list(APPEND ARGS -D CMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER})
  endif()
  if(ARG_NO_TREAT_WARNINGS_AS_ERRORS)
    list(APPEND ARGS -D TREAT_WARNINGS_AS_ERRORS=OFF)
  endif()
  assert_execute_process(
    "${CMAKE_COMMAND}" ${ARGS} --fresh -S project -B project/build)
endfunction()

# Asserts building the sample project.
#
# assert_build_project([EXPECT_FAIL])
#
# This function asserts whether the sample project can be built successfully.
# If the `EXPECT_FAIL` option is specified, it instead asserts whether the
# sample project failed to build.
function(assert_build_project)
  cmake_parse_arguments(PARSE_ARGV 0 ARG EXPECT_FAIL "" "")
  if(ARG_EXPECT_FAIL)
    list(APPEND ARGS EXPECT_FAIL)
  endif()
  assert_execute_process("${CMAKE_COMMAND}" --build project/build ${ARGS})
endfunction()
