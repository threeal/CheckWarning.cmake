cmake_minimum_required(VERSION 3.19)

project(
  CheckWarning
  VERSION 2.0.0
  DESCRIPTION "Check for compiler warnings in your CMake project"
  HOMEPAGE_URL https://github.com/threeal/CheckWarning.cmake/)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(CheckWarning)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR AND BUILD_TESTING)
  enable_testing()
  include(test/CheckWarningTest.cmake)
endif()

install(
  FILES cmake/CheckWarning.cmake
  DESTINATION lib/cmake
)
