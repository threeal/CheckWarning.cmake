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
cpmaddpackage(gh:threeal/CheckWarning.cmake@2.1.1)
include(CheckWarning)
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

## License

This project is licensed under the terms of the [MIT License](./LICENSE).

Copyright © 2023-2024 [Alfi Maulana](https://github.com/threeal)
