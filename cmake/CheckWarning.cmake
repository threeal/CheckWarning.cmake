# Function to get warning flags based on the compiler type.
# Arguments:
#   - VAR: The variable for which to store the warning flags.
function(_get_warning_flags VAR)
  if(MSVC)
    set(${VAR} /WX /permissive- /W4 /EHsc PARENT_SCOPE)
  else()
    set(${VAR} -Werror -Wall -Wextra -Wpedantic PARENT_SCOPE)
  endif()
endfunction()

# Function to enable warning checks on a specific target.
# Arguments:
#   - TARGET: The target for which to enable warning checks.
function(target_check_warning TARGET)
  # Determine if the target is an interface library or not.
  get_target_property(TARGET_TYPE ${TARGET} TYPE)
  if(${TARGET_TYPE} STREQUAL INTERFACE_LIBRARY)
    set(TYPE INTERFACE)
  else()
    set(TYPE PRIVATE)
  endif()

  # Append warning flags to the compile options.
  _get_warning_flags(FLAGS)
  target_compile_options(${TARGET} ${TYPE} ${FLAGS})
endfunction()

# Function to globally enable warning checks for all targets in the directory.
function(add_check_warning)
  _get_warning_flags(FLAGS)
  add_compile_options(${FLAGS})
endfunction()
