cmake_minimum_required(VERSION 3.21)

project(
  CheckWarning
  VERSION 2.1.1
  DESCRIPTION "Check for compiler warnings in your CMake project"
  HOMEPAGE_URL https://github.com/threeal/CheckWarning.cmake/
  LANGUAGES NONE
)

option(CHECK_WARNING_ENABLE_TESTS "Enable test targets.")
option(CHECK_WARNING_ENABLE_INSTALL "Enable install targets."
  "${PROJECT_IS_TOP_LEVEL}")

include(cmake/CheckWarning.cmake)

if(CHECK_WARNING_ENABLE_TESTS)
  enable_testing()
  add_subdirectory(test)
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
