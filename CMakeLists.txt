cmake_minimum_required(VERSION 3.19)

project(
  CheckWarning
  VERSION 2.0.1
  DESCRIPTION "Check for compiler warnings in your CMake project"
  HOMEPAGE_URL https://github.com/threeal/CheckWarning.cmake/
  LANGUAGES NONE
)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

if(CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR AND BUILD_TESTING)
  enable_testing()
  include(test/CheckWarningTest.cmake)
endif()

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  CheckWarningConfigVersion.cmake
  COMPATIBILITY SameMajorVersion
)

install(
  FILES
    cmake/CheckWarning.cmake
    cmake/CheckWarningConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/CheckWarningConfigVersion.cmake
  DESTINATION lib/cmake/CheckWarning
)
