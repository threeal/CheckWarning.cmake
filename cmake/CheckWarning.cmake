if(MSVC)
  set(WARNING_FLAGS /WX /permissive- /W4 /EHsc)
else()
  set(WARNING_FLAGS -Werror -Wall -Wextra -Wpedantic)
endif()

function(target_check_warning TARGET)
  # Determine if the target is an interface library or not
  get_target_property(TARGET_TYPE ${TARGET} TYPE)
  if(${TARGET_TYPE} STREQUAL INTERFACE_LIBRARY)
    set(TYPE INTERFACE)
  else()
    set(TYPE PRIVATE)
  endif()

  # Append warning flags to the compile options
  target_compile_options(${TARGET} ${TYPE} ${WARNING_FLAGS})
endfunction()

function(add_check_warning)
  add_compile_options(${WARNING_FLAGS})
endfunction()
