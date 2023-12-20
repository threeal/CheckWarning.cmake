cmake_minimum_required(VERSION 3.8)

project(CheckWarningTest)

include(CheckWarning)

add_library(lib INTERFACE)
target_include_directories(lib INTERFACE include)
target_check_warning(lib)

add_executable(correct EXCLUDE_FROM_ALL main.cpp)
target_link_libraries(correct PRIVATE lib)
target_check_warning(correct)

add_executable(incorrect EXCLUDE_FROM_ALL main.cpp)
target_link_libraries(incorrect PRIVATE lib)
target_compile_definitions(incorrect PRIVATE WITH_UNUSED)
target_check_warning(incorrect)

add_executable(with_parameters EXCLUDE_FROM_ALL main.cpp)
target_link_libraries(with_parameters PRIVATE lib)
target_compile_definitions(with_parameters PRIVATE WITH_UNUSED)
target_check_warning(with_parameters FLAGS $<IF:$<BOOL:${MSVC}>,/wd4101,-Wno-unused-variable>)
if(MSVC)
  target_compile_options(with_parameters PRIVATE /wd4101)
else()
  target_compile_options(with_parameters PRIVATE -Wno-unused-variable)
endif()

add_executable(correct_c EXCLUDE_FROM_ALL main.c)
target_check_warning(correct_c)

add_executable(incorrect_c EXCLUDE_FROM_ALL main.c)
target_compile_definitions(incorrect_c PRIVATE WITH_UNUSED)
target_check_warning(incorrect_c)

add_executable(with_parameters_c EXCLUDE_FROM_ALL main.c)
target_compile_definitions(with_parameters_c PRIVATE WITH_UNUSED)
target_check_warning(with_parameters_c)
if(MSVC)
  target_compile_options(with_parameters_c PRIVATE /wd4101)
else()
  target_compile_options(with_parameters_c PRIVATE -Wno-unused-variable)
endif()
