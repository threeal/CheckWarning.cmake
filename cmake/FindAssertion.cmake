set(DOWNLOAD_URL https://github.com/threeal/assertion-cmake/releases/download)
file(DOWNLOAD ${DOWNLOAD_URL}/v${Assertion_FIND_VERSION}/Assertion.tar.gz
  ${CMAKE_BINARY_DIR}/_deps/Assertion.tar.gz)

file(ARCHIVE_EXTRACT INPUT ${CMAKE_BINARY_DIR}/_deps/Assertion.tar.gz
  DESTINATION ${CMAKE_BINARY_DIR}/_deps)

include(CMakeFindDependencyMacro)
find_dependency(Assertion CONFIG PATHS ${CMAKE_BINARY_DIR}/_deps)
