cmake_minimum_required(VERSION 3.0)

project(CheckWarningTest)

if(DEFINED ENV{CPM_URL})
  include(../cmake/cpm.cmake)
  cpmaddpackage("$ENV{CPM_URL}")
else()
  add_subdirectory(.. ${CMAKE_CURRENT_BINARY_DIR}/devel.cmake)
endif()

add_library(lib INTERFACE)
target_include_directories(lib INTERFACE include)
devel_target_check_warning(lib)

add_executable(correct EXCLUDE_FROM_ALL main.cpp)
target_link_libraries(correct PRIVATE lib)
devel_target_check_warning(correct)

add_executable(incorrect EXCLUDE_FROM_ALL main.cpp)
target_link_libraries(incorrect PRIVATE lib)
target_compile_definitions(incorrect PRIVATE WITH_UNUSED)
devel_target_check_warning(incorrect)

add_executable(with_parameters EXCLUDE_FROM_ALL main.cpp)
target_link_libraries(with_parameters PRIVATE lib)
target_compile_definitions(with_parameters PRIVATE WITH_UNUSED)
devel_target_check_warning(with_parameters FLAGS -Wno-unused-variable MSVC_FLAGS /wd4101)
