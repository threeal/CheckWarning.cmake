cmake_minimum_required(VERSION 3.8)

project(Sample)

include(CheckWarning)

if(WITH_UNUSED)
  add_compile_definitions(WITH_UNUSED)
endif()

add_library(lib INTERFACE)
target_include_directories(lib INTERFACE include)
target_check_warning(lib)

add_executable(main src/main.cpp)
target_link_libraries(main PRIVATE lib)
target_check_warning(main)
if(IGNORE_UNUSED)
  target_compile_options(main PRIVATE $<IF:$<BOOL:${MSVC}>,/wd4101,-Wno-unused-variable>)
endif()

add_executable(main_c src/main.c)
target_link_libraries(main_c PRIVATE lib)
target_check_warning(main_c)
if(IGNORE_UNUSED)
  target_compile_options(main_c PRIVATE $<IF:$<BOOL:${MSVC}>,/wd4101,-Wno-unused-variable>)
endif()
