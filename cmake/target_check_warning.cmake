function(target_check_warning TARGET)
  cmake_parse_arguments(ARG "" "" "FLAGS;MSVC_FLAGS" ${ARGN})

  # Determine if the target is an interface library or not
  get_target_property(TARGET_TYPE ${TARGET} TYPE)
  if(${TARGET_TYPE} STREQUAL INTERFACE_LIBRARY)
    set(TYPE INTERFACE)
  else()
    set(TYPE PRIVATE)
  endif()

  # Append warning flags to the compile options
  if(MSVC)
    target_compile_options(${TARGET} ${TYPE} /WX /permissive- /W4 /w14640 /EHsc ${ARG_MSVC_FLAGS})
  else()
    target_compile_options(${TARGET} ${TYPE} -Werror -Wall -Wextra -Wpedantic $<$<COMPILE_LANGUAGE:CXX>:-Wnon-virtual-dtor> ${ARG_FLAGS})
  endif()
endfunction()
