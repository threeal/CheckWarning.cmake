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
cpmaddpackage(gh:threeal/CheckWarning.cmake@3.0.0)
```

## Usage

### Checking Warnings on a Target

To enable all recommended warnings on a target, use the [`target_check_warning`](#target_check_warning) function.

```cmake
add_executable(main main.cpp)
target_check_warning(main)
```

If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it treats all warnings from the target as errors. This will cause the build process to fail when a warning is triggered.

```cmake
target_check_warning(main TREAT_WARNINGS_AS_ERRORS)
```

### Checking Warnings Globally

To enable all recommended warnings on all targets in the directory, use the [`add_check_warning`](#add_check_warning) function. This function behaves the same as the [`target_check_warning`](#target_check_warning) function.

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

This function retrieves the warning flags for a specific compiler and saves them to the variable `<output_var>`. It determines the current compiler using the [`CMAKE_<LANG>_COMPILER_ID`](https://cmake.org/cmake/help/v3.21/variable/CMAKE_LANG_COMPILER_ID.html) variable and retrieves the corresponding warning flags, as specified in the table below:

| Compiler     | Warning Flags              |
| ------------ | -------------------------- |
| MSVC         | `/permissive- /W4 /EHsc`   |
| GNU or Clang | `-Wall -Wextra -Wpedantic` |

If the `TREAT_WARNINGS_AS_ERRORS` option is specified, it will also append the flag that treats warnings as errors, as specified in the table below:

| Compiler     | Flag      |
| ------------ | --------- |
| MSVC         | `/WX`     |
| GNU or Clang | `-Werror` |

For compilers not listed in the table above, this function will trigger a fatal error indicating that the compiler is unsupported.

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

Copyright © 2023-2024 [Alfi Maulana](https://github.com/threeal)
