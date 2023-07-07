cmake_minimum_required(VERSION 3.0)

project(hello_world_test)

if(DEFINED ENV{CPM_URL})
  include(../../cmake/cpm.cmake)
  cpmaddpackage("$ENV{CPM_URL}")
else()
  add_subdirectory(../.. ${CMAKE_CURRENT_BINARY_DIR}/devel.cmake)
endif()

hello_world()
