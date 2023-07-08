cmake_minimum_required(VERSION 3.0)

project(devel_target_check_warning_test)

if(DEFINED ENV{CPM_URL})
  include(../../cmake/cpm.cmake)
  cpmaddpackage("$ENV{CPM_URL}")
else()
  add_subdirectory(../.. ${CMAKE_CURRENT_BINARY_DIR}/devel.cmake)
endif()

add_executable(correct EXCLUDE_FROM_ALL main.cpp)
devel_target_check_warning(correct)

add_executable(incorrect EXCLUDE_FROM_ALL main.cpp)
target_compile_definitions(incorrect PRIVATE WITH_UNUSED)
devel_target_check_warning(incorrect)
