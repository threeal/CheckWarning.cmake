cmake_minimum_required(VERSION 3.0)

project(hello_world_test)

if(DEFINED ENV{CI})
  include(../../cmake/cpm.cmake)
  cpmaddpackage("gh:threeal/Devel.cmake#${GIT_COMMIT}")
else()
  add_subdirectory(../.. ${CMAKE_CURRENT_BINARY_DIR}/devel.cmake)
endif()

hello_world()
