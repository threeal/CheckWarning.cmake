include("${CMAKE_CURRENT_LIST_DIR}/../cmake/CheckWarning.cmake")

section("it should retrieve warning flags for MSVC")
  set(CMAKE_CXX_COMPILER_ID MSVC)

  get_warning_flags(FLAGS)
  assert("${FLAGS}" STREQUAL "/WX;/permissive-;/W4;/EHsc")
endsection()

section("it should retrieve warning flags for GNU")
  set(CMAKE_CXX_COMPILER_ID GNU)

  get_warning_flags(FLAGS)
  assert("${FLAGS}" STREQUAL "-Werror;-Wall;-Wextra;-Wpedantic")
endsection()

section("it should retrieve warning flags for Clang")
  set(CMAKE_CXX_COMPILER_ID AppleClang)

  get_warning_flags(FLAGS)
  assert("${FLAGS}" STREQUAL "-Werror;-Wall;-Wextra;-Wpedantic")
endsection()

section("it should fail to retrieve warning flags for unsupported compilers")
  set(CMAKE_CXX_COMPILER_ID unsupported)

  assert_fatal_error(
    CALL get_warning_flags FLAGS
    MESSAGE "CheckWarning: Unsupported compiler for retrieving "
      "warning flags: unsupported")
endsection()
