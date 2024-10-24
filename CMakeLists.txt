cmake_minimum_required(VERSION 3.21)

project(
  CheckWarning
  VERSION 3.1.0
  DESCRIPTION "Check for compiler warnings in CMake projects"
  HOMEPAGE_URL https://github.com/threeal/CheckWarning.cmake
  LANGUAGES NONE)

option(CHECK_WARNING_ENABLE_TESTS "Enable test targets.")
option(CHECK_WARNING_ENABLE_INSTALL "Enable install targets." "${PROJECT_IS_TOP_LEVEL}")

list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Prefer system packages over the find modules provided by this project.
if(NOT DEFINED CMAKE_FIND_PACKAGE_PREFER_CONFIG)
  set(CMAKE_FIND_PACKAGE_PREFER_CONFIG TRUE)
endif()

include(CheckWarning)

if(CHECK_WARNING_ENABLE_TESTS)
  enable_testing()

  find_package(Assertion 2.0.0 REQUIRED)

  list(APPEND CMAKE_SCRIPT_TEST_DEFINITIONS CMAKE_MODULE_PATH)
  if(DEFINED CMAKE_CXX_COMPILER)
   list(APPEND CMAKE_SCRIPT_TEST_DEFINITIONS CMAKE_CXX_COMPILER)
  endif()

  add_cmake_script_test(test/test_add_check_warning.cmake)
  add_cmake_script_test(test/test_get_warning_flags.cmake)
  add_cmake_script_test(test/test_target_check_warning.cmake)
endif()

if(CHECK_WARNING_ENABLE_INSTALL)
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/cmake/CheckWarningConfig.cmake
    "list(PREPEND CMAKE_MODULE_PATH \${CMAKE_CURRENT_LIST_DIR})\n"
    "include(CheckWarning)\n")

  include(CMakePackageConfigHelpers)
  write_basic_package_version_file(cmake/CheckWarningConfigVersion.cmake
    COMPATIBILITY SameMajorVersion ARCH_INDEPENDENT)

  install(
    FILES cmake/CheckWarning.cmake
      ${CMAKE_CURRENT_BINARY_DIR}/cmake/CheckWarningConfig.cmake
      ${CMAKE_CURRENT_BINARY_DIR}/cmake/CheckWarningConfigVersion.cmake
    DESTINATION lib/cmake/CheckWarning)

  set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}")
  include(CPack)
endif()
