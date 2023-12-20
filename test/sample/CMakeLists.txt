cmake_minimum_required(VERSION 3.5)

project(Sample)

include(CheckWarning)

add_library(lib INTERFACE)
target_include_directories(lib INTERFACE include)
target_check_warning(lib)

add_executable(main main.cpp)
target_link_libraries(main PRIVATE lib)
target_check_warning(main)

add_executable(main_c main.c)
target_check_warning(main_c)

foreach(TARGET main main_c)
  if(WITH_UNUSED)
    target_compile_definitions(${TARGET} PRIVATE WITH_UNUSED)
  endif()

  if(IGNORE_UNUSED)
    if(MSVC)
      target_compile_options(${TARGET} PRIVATE /wd4101)
    else()
      target_compile_options(${TARGET} PRIVATE -Wno-unused-variable)
    endif()
  endif()
endforeach()
