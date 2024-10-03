include("${CMAKE_CURRENT_LIST_DIR}/../cmake/CheckWarning.cmake")

section("it should get warning flags for MSVC")
  set(MSVC TRUE)

  get_warning_flags(FLAGS)
  assert("${FLAGS}" STREQUAL "/WX;/permissive-;/W4;/EHsc")
endsection()

section("it should get warning flags for other compilers")
  unset(MSVC)

  get_warning_flags(FLAGS)
  assert("${FLAGS}" STREQUAL "-Werror;-Wall;-Wextra;-Wpedantic")
endsection()
