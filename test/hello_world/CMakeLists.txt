cmake_minimum_required(VERSION 3.0)

project(hello_world_test)

include(../../cmake/cpm.cmake)

cpmaddpackage(
  NAME Devel.cmake
  GITHUB_REPOSITORY threeal/Devel.cmake
  GIT_TAG ${GIT_COMMIT}
  NO_CACHE TRUE
)

hello_world()
