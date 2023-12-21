# Set warning flags based on the compiler type.
if(MSVC)
  set(WARNING_FLAGS /WX /permissive- /W4 /EHsc)
else()
  set(WARNING_FLAGS -Werror -Wall -Wextra -Wpedantic)
endif()

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
  target_compile_options(${TARGET} ${TYPE} ${WARNING_FLAGS})
endfunction()

# Function to globally enable warning checks for all targets in the directory.
function(add_check_warning)
  add_compile_options(${WARNING_FLAGS})
endfunction()
