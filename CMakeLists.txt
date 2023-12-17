cmake_minimum_required(VERSION 3.19)

project(
  CheckWarning
  VERSION 1.2.0
  DESCRIPTION "Check for compiler warnings in your CMake project"
  HOMEPAGE_URL https://github.com/threeal/CheckWarning.cmake/)

include(cmake/target_check_warning.cmake)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR AND BUILD_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()
