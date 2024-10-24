cmake_minimum_required(VERSION 3.21)

include(Assertion)
include(CheckWarning)

section("retrieve warning flags for MSVC")
  set(CMAKE_CXX_COMPILER_ID MSVC)
  unset(CMAKE_CXX_SIMULATE_ID)

  section("it should retrieve warning flags")
    get_warning_flags(FLAGS)
    assert("${FLAGS}" STREQUAL "/permissive-;/W4;/EHsc")
  endsection()

  section("it should retrieve warning flags when treating warnings as errors")
    get_warning_flags(FLAGS TREAT_WARNINGS_AS_ERRORS)
    assert("${FLAGS}" STREQUAL "/permissive-;/W4;/EHsc;/WX")
  endsection()
endsection()

section("retrieve warning flags for MSVC with Clang")
  set(CMAKE_CXX_COMPILER_ID Clang)
  set(CMAKE_CXX_SIMULATE_ID MSVC)

  section("it should retrieve warning flags")
    get_warning_flags(FLAGS)
    assert("${FLAGS}" STREQUAL "/permissive-;/W4;/EHsc")
  endsection()

  section("it should retrieve warning flags when treating warnings as errors")
    get_warning_flags(FLAGS TREAT_WARNINGS_AS_ERRORS)
    assert("${FLAGS}" STREQUAL "/permissive-;/W4;/EHsc;/WX")
  endsection()
endsection()

section("retrieve warning flags for GNU")
  set(CMAKE_CXX_COMPILER_ID GNU)
  set(CMAKE_CXX_SIMULATE_ID "")

  section("it should retrieve warning flags")
    get_warning_flags(FLAGS)
    assert("${FLAGS}" STREQUAL "-Wall;-Wextra;-Wpedantic")
  endsection()

  section("it should retrieve warning flags when treating warnings as errors")
    get_warning_flags(FLAGS TREAT_WARNINGS_AS_ERRORS)
    assert("${FLAGS}" STREQUAL "-Wall;-Wextra;-Wpedantic;-Werror")
  endsection()
endsection()

section("retrieve warning flags for Clang")
  set(CMAKE_CXX_COMPILER_ID AppleClang)
  set(CMAKE_CXX_SIMULATE_ID "")

  section("it should retrieve warning flags")
    get_warning_flags(FLAGS)
    assert("${FLAGS}" STREQUAL "-Wall;-Wextra;-Wpedantic")
  endsection()

  section("it should retrieve warning flags when treating warnings as errors")
    get_warning_flags(FLAGS TREAT_WARNINGS_AS_ERRORS)
    assert("${FLAGS}" STREQUAL "-Wall;-Wextra;-Wpedantic;-Werror")
  endsection()
endsection()

section("it should fail to retrieve warning flags for unsupported compilers")
  set(CMAKE_CXX_COMPILER_ID unsupported)
  set(CMAKE_CXX_SIMULATE_ID "")

  assert_call(get_warning_flags FLAGS EXPECT_ERROR STREQUAL
    "CheckWarning: Unsupported compiler for retrieving warning flags: unsupported")
endsection()
