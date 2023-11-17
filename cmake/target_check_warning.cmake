function(target_check_warning TARGET)
  cmake_parse_arguments(ARG "" "" "FLAGS" ${ARGN})

  # Determine if the target is an interface library or not
  get_target_property(TARGET_TYPE ${TARGET} TYPE)
  if(${TARGET_TYPE} STREQUAL INTERFACE_LIBRARY)
    set(TYPE INTERFACE)
  else()
    set(TYPE PRIVATE)
  endif()

  # Append warning flags to the compile options
  if(MSVC)
    target_compile_options(${TARGET} ${TYPE} /WX /permissive- /W4 /EHsc ${ARG_FLAGS})
  else()
    target_compile_options(${TARGET} ${TYPE} -Werror -Wall -Wextra -Wpedantic ${ARG_FLAGS})
  endif()
endfunction()
