file(
  DOWNLOAD https://raw.githubusercontent.com/threeal/assertion-cmake/49002300a884a79e02242e297521f946a621fdf9/cmake/Assertion.cmake
    ${CMAKE_BINARY_DIR}/cmake/Assertion.cmake
  EXPECTED_MD5 0555f16abace50ce05105dea8053a9af)
include(${CMAKE_BINARY_DIR}/cmake/Assertion.cmake)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  Assertion REQUIRED_VARS ASSERTION_VERSION VERSION_VAR ASSERTION_VERSION)
