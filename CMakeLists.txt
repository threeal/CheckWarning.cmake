cmake_minimum_required(VERSION 3.21)

project(
  CheckWarning
  VERSION 2.1.1
  DESCRIPTION "Check for compiler warnings in your CMake project"
  HOMEPAGE_URL https://github.com/threeal/CheckWarning.cmake/
  LANGUAGES NONE
)

option(CHECK_WARNING_ENABLE_TESTS "Enable test targets.")
option(CHECK_WARNING_ENABLE_INSTALL "Enable install targets." "${PROJECT_IS_TOP_LEVEL}")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

include(cmake/CheckWarning.cmake)

if(CHECK_WARNING_ENABLE_TESTS)
  enable_testing()

  find_package(Assertion 1.0.0 REQUIRED)
  assertion_add_test(test/check_warning.cmake)
endif()

if(CHECK_WARNING_ENABLE_INSTALL)
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
endif()
