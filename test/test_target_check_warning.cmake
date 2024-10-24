cmake_minimum_required(VERSION 3.21)

file(REMOVE_RECURSE project)

include(${CMAKE_CURRENT_LIST_DIR}/project_helper.cmake)

section("it should generate the sample project")
  file(WRITE project/lib.cpp "void lib_main() {}\n")

  file(WRITE project/main.cpp
    "void lib_main();\n"
    "\n"
    "int main() {\n"
    "  lib_main();\n"
    "  return 0;\n"
    "}\n")

  file(WRITE project/CMakeLists.txt
    ${PROJECT_CMAKELISTS_HEADER_SRC}
    "\n"
    "add_library(lib lib.cpp)\n"
    "target_check_warning(lib \${WARNING_OPTIONS})\n"
    "\n"
    "get_target_property(FLAGS lib COMPILE_OPTIONS)\n"
    "assert(FLAGS STREQUAL WARNING_FLAGS)\n"
    "\n"
    "add_executable(main main.cpp)\n"
    "target_link_libraries(main PRIVATE lib)\n"
    "\n"
    "get_target_property(FLAGS main COMPILE_OPTIONS)\n"
    "assert(FLAGS STREQUAL \"FLAGS-NOTFOUND\")\n")
endsection()

section("it should build the sample project")
  assert_configure_project()
  assert_build_project()
endsection()

section("it should add an unused variable to the main.cpp file")
  file(WRITE project/main.cpp
    "void lib_main();\n"
    "\n"
    "int main() {\n"
    "  int unused;\n"
    "  lib_main();\n"
    "  return 0;\n"
    "}\n")
endsection()

section("it should build the sample project")
  assert_configure_project()
  assert_build_project()
endsection()

section("it should add an unused variable to the lib.cpp file")
  file(WRITE project/lib.cpp
    "void lib_main() {\n"
    "  int unused;\n"
    "}\n")
endsection()

section("it should fail to build the sample project")
  assert_configure_project()
  assert_build_project(EXPECT_FAIL)
endsection()

section("it should build the sample project if not treating warnings as errors")
  assert_configure_project(NO_TREAT_WARNINGS_AS_ERRORS)
  assert_build_project()
endsection()

section("it should check for warnings only in an interface")
  file(WRITE project/CMakeLists.txt
    ${PROJECT_CMAKELISTS_HEADER_SRC}
    "\n"
    "add_library(iface INTERFACE)\n"
    "target_check_warning(iface \${WARNING_OPTIONS})\n"
    "\n"
    "get_target_property(FLAGS iface INTERFACE_COMPILE_OPTIONS)\n"
    "assert(FLAGS STREQUAL WARNING_FLAGS)\n"
    "\n"
    "add_library(lib lib.cpp)\n"
    "\n"
    "get_target_property(FLAGS lib COMPILE_OPTIONS)\n"
    "assert(FLAGS STREQUAL \"FLAGS-NOTFOUND\")\n"
    "\n"
    "add_executable(main main.cpp)\n"
    "target_link_libraries(main PRIVATE iface lib)\n"
    "\n"
    "get_target_property(FLAGS main COMPILE_OPTIONS)\n"
    "assert(FLAGS STREQUAL \"FLAGS-NOTFOUND\")\n")
endsection()

section("it should fail to build the sample project")
  assert_configure_project()
  assert_build_project(EXPECT_FAIL)
endsection()

section("it should build the sample project if not treating warnings as errors")
  assert_configure_project(NO_TREAT_WARNINGS_AS_ERRORS)
  assert_build_project()
endsection()

section("it should remove the unused variable from the main.cpp file")
  file(WRITE project/main.cpp
    "void lib_main();\n"
    "\n"
    "int main() {\n"
    "  lib_main();\n"
    "  return 0;\n"
    "}\n")
endsection()

section("it should build the sample project")
  assert_configure_project()
  assert_build_project()
endsection()

file(REMOVE_RECURSE project)
