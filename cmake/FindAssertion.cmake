file(
  DOWNLOAD https://github.com/threeal/assertion-cmake/releases/download/v2.0.0/Assertion.cmake
    ${CMAKE_BINARY_DIR}/cmake/Assertion.cmake
  EXPECTED_MD5 5ebe475aee6fc5660633152f815ce9f6)
include(${CMAKE_BINARY_DIR}/cmake/Assertion.cmake)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  Assertion REQUIRED_VARS ASSERTION_VERSION VERSION_VAR ASSERTION_VERSION)

list(PREPEND CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR}/cmake)
