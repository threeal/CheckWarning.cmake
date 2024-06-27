cmake_minimum_required(VERSION 3.8)

project(Sample)

find_package(CheckWarning REQUIRED PATHS ${CMAKE_CURRENT_SOURCE_DIR}/../../cmake)

if(USE_GLOBAL)
  add_check_warning()
endif()

if(WITH_UNUSED)
  add_compile_definitions(WITH_UNUSED)
endif()

add_library(lib INTERFACE)
target_include_directories(lib INTERFACE include)
if(NOT USE_GLOBAL)
  target_check_warning(lib)
endif()

add_executable(main src/main.cpp)
target_link_libraries(main PRIVATE lib)
if(NOT USE_GLOBAL)
  target_check_warning(main)
endif()
if(IGNORE_UNUSED)
  target_compile_options(main PRIVATE $<IF:$<BOOL:${MSVC}>,/wd4101,-Wno-unused-variable>)
endif()

add_executable(main_c src/main.c)
target_link_libraries(main_c PRIVATE lib)
if(NOT USE_GLOBAL)
  target_check_warning(main_c)
endif()
if(IGNORE_UNUSED)
  target_compile_options(main_c PRIVATE $<IF:$<BOOL:${MSVC}>,/wd4101,-Wno-unused-variable>)
endif()
