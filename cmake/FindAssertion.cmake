file(
  DOWNLOAD https://github.com/threeal/assertion-cmake/releases/download/v1.0.0/Assertion.cmake
    ${CMAKE_BINARY_DIR}/cmake/Assertion.cmake
  EXPECTED_MD5 1d8ec589d6cc15772581bf77eb3873ff)
include(${CMAKE_BINARY_DIR}/cmake/Assertion.cmake)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Assertion REQUIRED_VARS ASSERTION_LIST_FILE)
