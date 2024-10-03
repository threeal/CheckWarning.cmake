# CheckWarning.cmake

CheckWarning.cmake is a [CMake](https://cmake.org) module that provides utility functions for checking compiler warnings during your project's build process.
This module mainly contains two functions: a `target_check_warning` function that assists in checking all recommended warnings on a given target, and an `add_check_warning` function that behaves like `target_check_warning` but affects all targets globally in the directory.

## Integration

### Including the Script File

You can integrate this module into your project by including the [CheckWarning.cmake](./cmake/CheckWarning.cmake) file in your project.

```cmake
include(CheckWarning)
```

### Using CPM.cmake

Alternatively, you can use [CPM.cmake](https://github.com/cpm-cmake/CPM.cmake) to seamlessly integrate this module into your project.

```cmake
cpmaddpackage(gh:threeal/CheckWarning.cmake@2.2.0)
```

## Usage

### Checking Warnings on a Target

To enable all recommended warnings on a target and treat them as errors, use the `target_check_warning` function. This will cause the build process to fail when a warning is violated.

```cmake
add_executable(main main.cpp)
target_check_warning(main)
```

### Ignoring Specific Warnings on a Target

You can use the `target_compile_options` function to ignore specific warnings on a target.

```cmake
target_check_warning(main)
target_compile_options(main PRIVATE -Wno-unused-variable)
```

### Checking Warnings Globally

To enable all recommended warnings on all targets in the directory, use the `add_check_warning` function. This function behaves the same as the `target_check_warning` function.

```cmake
add_check_warning()

add_library(lib lib.cpp)
add_executable(main main.cpp)
```

### Get Warning Flags

To retrieve the warning flags without adding them to a target, use the `get_warning_flags` function.

```cmake
get_warning_flags(FLAGS)
message("Warning flags: ${FLAGS}")
```

## API Reference

### `CHECK_WARNING_VERSION`

This variable contains the version of the included [`CheckWarning.cmake`](./cmake/CheckWarning.cmake) module.

### `get_warning_flags`

Retrieves warning flags based on the current compiler.

```cmake
get_warning_flags(<output_var>)
```

This function retrieves the warning flags for a specific compiler and saves them to a variable named `<output_var>`. The function determines the current compiler using the [`CMAKE_<LANG>_COMPILER_ID`](https://cmake.org/cmake/help/v3.21/variable/CMAKE_LANG_COMPILER_ID.html) variable and retrieves the warning flags for that compiler, as specified in the following table:

| Compiler     | Warning Flags                      |
| ------------ | ---------------------------------- |
| MSVC         | `/WX /permissive- /W4 /EHsc`       |
| GNU or Clang | `-Werror -Wall -Wextra -Wpedantic` |

For compilers not specified in the table above, this function will send a fatal error message explaining that it does not support that compiler.

### `target_check_warning`

Enables warning checks on a specific target.

```cmake
target_check_warning(<target>)
```

This function enables warning checks on the `<target>` by appending warning flags from the [`get_warning_flags`](#get_warning_flags) function to the compile options of that target. It is equivalent to calling the [`target_compile_options`](https://cmake.org/cmake/help/v3.21/command/target_compile_options.html) command on the target using the warning flags.

### `add_check_warning`

Enables warning checks on all targets in the current directory.

```cmake
add_check_warning()
```

This function enables warning checks on all targets in the current directory by appending warning flags from the [`get_warning_flags`](#get_warning_flags) function to the default compile options. It is equivalent to calling the [`add_compile_options`](https://cmake.org/cmake/help/v3.21/command/add_compile_options.html) command using the warning flags.

## License

This project is licensed under the terms of the [MIT License](./LICENSE).

Copyright © 2023-2024 [Alfi Maulana](https://github.com/threeal)
