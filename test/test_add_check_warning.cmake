file(REMOVE_RECURSE project)

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
    "cmake_minimum_required(VERSION 3.5)\n"
    "project(Sample LANGUAGES CXX)\n"
    "\n"
    "include(${ASSERTION_LIST_FILE})\n"
    "\n"
    "include(${CMAKE_CURRENT_LIST_DIR}/../cmake/CheckWarning.cmake)\n"
    "get_warning_flags(WARNING_FLAGS)\n"
    "\n"
    "add_library(lib lib.cpp)\n"
    "\n"
    "get_directory_property(FLAGS COMPILE_OPTIONS)\n"
    "assert(NOT FLAGS)\n"
    "\n"
    "add_check_warning(lib)\n"
    "\n"
    "get_directory_property(FLAGS COMPILE_OPTIONS)\n"
    "assert(FLAGS STREQUAL WARNING_FLAGS)\n"
    "\n"
    "add_executable(main main.cpp)\n"
    "target_link_libraries(main PRIVATE lib)\n")
endsection()

section("it should build the sample project")
  assert_execute_process("${CMAKE_COMMAND}" --fresh -S project -B project/build)
  assert_execute_process("${CMAKE_COMMAND}" --build project/build)
endsection()

section("it should add an unused variable to the lib.cpp file")
  file(WRITE project/lib.cpp
    "void lib_main() {\n"
    "  int unused;\n"
    "}\n")
endsection()

section("it should build the sample project")
  assert_execute_process("${CMAKE_COMMAND}" --fresh -S project -B project/build)
  assert_execute_process("${CMAKE_COMMAND}" --build project/build)
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

section("it should fail to build the sample project")
  assert_execute_process("${CMAKE_COMMAND}" --fresh -S project -B project/build)
  assert_execute_process("${CMAKE_COMMAND}" --build project/build ERROR "")
endsection()

file(REMOVE_RECURSE project)
