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
set(CHECK_WARNING_VERSION 2.2.0)

# Retrieves warning flags based on the current compiler.
#
# get_warning_flags(<output_var>)
#
# This function retrieves the warning flags for a specific compiler and saves
# them to a variable named `<output_var>`. The function determines the current
# compiler using the `CMAKE_<LANG>_COMPILER_ID` variable and retrieves the
# warning flags for that compiler, as specified in the following table:
#
# | Compiler     | Warning Flags                      |
# | ------------ | ---------------------------------- |
# | MSVC         | `/WX /permissive- /W4 /EHsc`       |
# | GNU or Clang | `-Werror -Wall -Wextra -Wpedantic` |
#
# For compilers not specified in the table above, this function will send a
# fatal error message explaining that it does not support that compiler.
function(get_warning_flags OUTPUT_VAR)
  if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    set("${OUTPUT_VAR}" /WX /permissive- /W4 /EHsc PARENT_SCOPE)
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    set("${OUTPUT_VAR}" -Werror -Wall -Wextra -Wpedantic PARENT_SCOPE)
  else()
    message(FATAL_ERROR "CheckWarning: Unsupported compiler for retrieving "
      "warning flags: ${CMAKE_CXX_COMPILER_ID}")
  endif()
endfunction()

# Enables warning checks on a specific target.
#
# target_check_warning(<target>)
#
# This function enables warning checks on the `<target>` by appending warning
# flags from the `get_warning_flags` function to the compile options of that
# target. It is equivalent to calling the `target_compile_options` command on
# the target using the warning flags.
function(target_check_warning TARGET)
  # Determine if the target is an interface library or not.
  get_target_property(TARGET_TYPE "${TARGET}" TYPE)
  if(TARGET_TYPE STREQUAL INTERFACE_LIBRARY)
    set(TYPE INTERFACE)
  else()
    set(TYPE PRIVATE)
  endif()

  # Append warning flags to the compile options.
  get_warning_flags(FLAGS)
  target_compile_options("${TARGET}" "${TYPE}" ${FLAGS})
endfunction()

# Enables warning checks on all targets in the current directory.
#
# add_check_warning()
#
# This function enables warning checks on all targets in the current directory
# by appending warning flags from the `get_warning_flags` function to the
# default compile options. It is equivalent to calling the `add_compile_options`
# command using the warning flags.
function(add_check_warning)
  get_warning_flags(FLAGS)
  add_compile_options(${FLAGS})
endfunction()
