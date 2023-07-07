cmake_minimum_required(VERSION 3.0)

project(hello_world_test)

if(DEFINED ENV{GITHUB_REPOSITORY} AND DEFINED ENV{GITHUB_SHA})
  include(../../cmake/cpm.cmake)
  cpmaddpackage("gh:$ENV{GITHUB_REPOSITORY}#$ENV{GITHUB_SHA}")
else()
  add_subdirectory(../.. ${CMAKE_CURRENT_BINARY_DIR}/devel.cmake)
endif()

hello_world()
