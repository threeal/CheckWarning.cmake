# CheckWarning.cmake

Check for compiler warnings in [CMake](https://cmake.org) projects.

This module enables compiler warnings to be checked easily in CMake projects. By default, it enables all recommended warning flags on targets across different compilers, preventing users from having to manually specify warning flags to be enabled.

This module provides two utility functions for checking compiler warnings:
- [`target_check_warning`](#target_check_warning): For checking compiler warnings on a single target.
- [`add_check_warning`](#add_check_warning): For checking compiler warnings on all targets in the current directory.

These functions enable all recommended warning flags on the targets and can optionally be set to treat the warnings as errors.

## Key Features

- Supports checking warnings on [MSVC](https://visualstudio.microsoft.com/vs/features/cplusplus/), [GNU](https://gcc.gnu.org/), and [Clang](https://clang.llvm.org/) compilers.
- Optionally treats warnings as errors.
- Simple syntax and easy integration.

## Usage Guide

### Module Integration

The recommended way to integrate this module into a project is by downloading it during the project configuration using the [`file(DOWNLOAD)`](https://cmake.org/cmake/help/v3.21/command/file.html#download) function:

```cmake
file(
  DOWNLOAD https://github.com/threeal/CheckWarning.cmake/releases/download/v3.2.0/CheckWarning.cmake
    ${CMAKE_BINARY_DIR}/cmake/CheckWarning.cmake
  EXPECTED_MD5 8f9c3170e816ba99a3ddc6848a8456f0)

include(${CMAKE_BINARY_DIR}/cmake/CheckWarning.cmake)
```

Alternatively, to support offline mode, this module can also be vendored directly into a project and included normally using the [`include`](https://cmake.org/cmake/help/v3.21/command/include.html) function.

### Check Warnings on Targets

Use the [`target_check_warning`](#target_check_warning) function to check for compiler warnings on a single target.

```cmake
add_executable(main main.cpp)
target_check_warning(main)
```

If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it treats all warnings from the target as errors. This will cause the build process to fail when a warning is triggered.

```cmake
target_check_warning(main TREAT_WARNINGS_AS_ERRORS)
```

Alternatively, the [`add_check_warning`](#add_check_warning) function can be used to check for compiler warnings on all targets in the current directory.

```cmake
add_check_warning(TREAT_WARNINGS_AS_ERRORS)

add_library(lib lib.cpp)
add_executable(main main.cpp)
```

### Get Warning Flags

To retrieve the warning flags without adding them to a target, use the [`get_warning_flags`](#get_warning_flags) function.

```cmake
get_warning_flags(FLAGS)
message("Warning flags: ${FLAGS}")
```

Use the `TREAT_WARNINGS_AS_ERRORS` option to also include the flag that treats warnings as errors.

```cmake
get_warning_flags(FLAGS TREAT_WARNINGS_AS_ERRORS)
```

## API Reference

### `CHECK_WARNING_VERSION`

This variable contains the version of the included [`CheckWarning.cmake`](./cmake/CheckWarning.cmake) module.

### `get_warning_flags`

Retrieves warning flags based on the current compiler.

```cmake
get_warning_flags(<output_var> [TREAT_WARNINGS_AS_ERRORS])
```

This function retrieves the warning flags for the current compiler and saves them to the variable `<output_var>`. It determines the compiler using the [`CMAKE_CXX_COMPILER_ID`](https://cmake.org/cmake/help/v3.21/variable/CMAKE_LANG_COMPILER_ID.html) variable and retrieves the corresponding warning flags, as shown in the table below:

| Compiler     | Warning Flags              |
| ------------ | -------------------------- |
| MSVC         | `/permissive- /W4 /EHsc`   |
| GNU or Clang | `-Wall -Wextra -Wpedantic` |

If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it appends the flag that treats warnings as errors, as shown in the table below:

| Compiler     | Flag      |
| ------------ | --------- |
| MSVC         | `/WX`     |
| GNU or Clang | `-Werror` |

If the compiler is simulating another compiler, determined by the existence of the [`CMAKE_CXX_SIMULATE_ID`](https://cmake.org/cmake/help/v3.21/variable/CMAKE_LANG_SIMULATE_ID.html) variable, it will use that variable to determine the warning flags.

For compilers not listed in the table above, this function will trigger a fatal error, indicating that the compiler is unsupported.

### `target_check_warning`

Enables warning checks on a specific target.

```cmake
target_check_warning(<target> [TREAT_WARNINGS_AS_ERRORS])
```

This function enables warning checks on the `<target>` by appending warning flags from the [`get_warning_flags`](#get_warning_flags) function to the compile options of that target. It is equivalent to calling the [`target_compile_options`](https://cmake.org/cmake/help/v3.21/command/target_compile_options.html) command on the target with the warning flags.

If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it will also append the flag that treats warnings as errors.

### `add_check_warning`

Enables warning checks on all targets in the current directory.

```cmake
add_check_warning([TREAT_WARNINGS_AS_ERRORS])
```

This function enables warning checks on all targets in the current directory by appending warning flags from the [`get_warning_flags`](#get_warning_flags) function to the default compile options. It is equivalent to calling the [`add_compile_options`](https://cmake.org/cmake/help/v3.21/command/add_compile_options.html) command with the warning flags.

If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it will also append the flag that treats warnings as errors.

## License

This project is licensed under the terms of the [MIT License](./LICENSE).

Copyright © 2023-2026 [Alfi Maulana](https://github.com/threeal)
