function(devel_target_check_warning target)
  target_compile_options(${target} PRIVATE -Werror -Wall -Wextra -Wnon-virtual-dtor -Wpedantic ${ARGN})
endfunction()
