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

# Function to get warning flags based on the compiler type.
# Arguments:
#   - VAR: The variable for which to store the warning flags.
function(get_warning_flags VAR)
  if(MSVC)
    set("${VAR}" /WX /permissive- /W4 /EHsc PARENT_SCOPE)
  else()
    set("${VAR}" -Werror -Wall -Wextra -Wpedantic PARENT_SCOPE)
  endif()
endfunction()

# Function to enable warning checks on a specific target.
# Arguments:
#   - TARGET: The target for which to enable warning checks.
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

# Function to globally enable warning checks for all targets in the directory.
function(add_check_warning)
  get_warning_flags(FLAGS)
  add_compile_options(${FLAGS})
endfunction()
