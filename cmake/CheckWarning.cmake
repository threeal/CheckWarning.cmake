# MIT License
#
# Copyright (c) 2023-2024 Alfi Maulana
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# This variable contains the version of the included `CheckWarning.cmake` module.
set(CHECK_WARNING_VERSION 3.0.0)

# Retrieves warning flags based on the current compiler.
#
# get_warning_flags(<output_var> [TREAT_WARNINGS_AS_ERRORS])
#
# This function retrieves the warning flags for a specific compiler and saves
# them to the variable `<output_var>`. It determines the current compiler using
# the `CMAKE_<LANG>_COMPILER_ID` variable and retrieves the corresponding
# warning flags, as specified in the table below:
#
# | Compiler     | Warning Flags              |
# | ------------ | -------------------------- |
# | MSVC         | `/permissive- /W4 /EHsc`   |
# | GNU or Clang | `-Wall -Wextra -Wpedantic` |
#
# If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it will also append the
# flag that treats warnings as errors, as specified in the table below:
#
# | Compiler     | Flag      |
# | ------------ | --------- |
# | MSVC         | `/WX`     |
# | GNU or Clang | `-Werror` |
#
# For compilers not listed in the table above, this function will trigger a
# fatal error indicating that the compiler is unsupported.
function(get_warning_flags OUTPUT_VAR)
  cmake_parse_arguments(PARSE_ARGV 1 ARG TREAT_WARNINGS_AS_ERRORS "" "")

  if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    set(FLAGS /permissive- /W4 /EHsc)
    if(ARG_TREAT_WARNINGS_AS_ERRORS)
      list(APPEND FLAGS /WX)
    endif()
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    set(FLAGS -Wall -Wextra -Wpedantic)
    if(ARG_TREAT_WARNINGS_AS_ERRORS)
      list(APPEND FLAGS -Werror)
    endif()
  else()
    message(FATAL_ERROR "CheckWarning: Unsupported compiler for retrieving "
      "warning flags: ${CMAKE_CXX_COMPILER_ID}")
  endif()

  set("${OUTPUT_VAR}" ${FLAGS} PARENT_SCOPE)
endfunction()

# Enables warning checks on a specific target.
#
# target_check_warning(<target> [TREAT_WARNINGS_AS_ERRORS])
#
# This function enables warning checks on the `<target>` by appending warning
# flags from the `get_warning_flags` function to the compile options of that
# target. It is equivalent to calling the `target_compile_options` command on
# the target with the warning flags.
#
# If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it will also append the
# flag that treats warnings as errors.
function(target_check_warning TARGET)
  cmake_parse_arguments(PARSE_ARGV 1 ARG TREAT_WARNINGS_AS_ERRORS "" "")

  if(ARG_TREAT_WARNINGS_AS_ERRORS)
    get_warning_flags(FLAGS TREAT_WARNINGS_AS_ERRORS)
  else()
    get_warning_flags(FLAGS)
  endif()

  get_target_property(TARGET_TYPE "${TARGET}" TYPE)
  if(TARGET_TYPE STREQUAL INTERFACE_LIBRARY)
    target_compile_options("${TARGET}" INTERFACE ${FLAGS})
  else()
    target_compile_options("${TARGET}" PRIVATE ${FLAGS})
  endif()
endfunction()

# Enables warning checks on all targets in the current directory.
#
# add_check_warning([TREAT_WARNINGS_AS_ERRORS])
#
# This function enables warning checks on all targets in the current directory
# by appending warning flags from the `get_warning_flags` function to the
# default compile options. It is equivalent to calling the `add_compile_options`
# command with the warning flags.
#
# If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it will also append the
# flag that treats warnings as errors.
function(add_check_warning)
  cmake_parse_arguments(PARSE_ARGV 0 ARG TREAT_WARNINGS_AS_ERRORS "" "")

  if(ARG_TREAT_WARNINGS_AS_ERRORS)
    get_warning_flags(FLAGS TREAT_WARNINGS_AS_ERRORS)
  else()
    get_warning_flags(FLAGS)
  endif()

  add_compile_options(${FLAGS})
endfunction()
