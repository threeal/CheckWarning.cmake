# CheckWarning.cmake

[![version](https://img.shields.io/github/v/release/threeal/CheckWarning.cmake?style=flat-square)](https://github.com/threeal/CheckWarning.cmake/releases)
[![license](https://img.shields.io/github/license/threeal/CheckWarning.cmake?style=flat-square)](./LICENSE)
[![test status](https://img.shields.io/github/actions/workflow/status/threeal/CheckWarning.cmake/test.yaml?branch=main&style=flat-square)](https://github.com/threeal/CheckWarning.cmake/actions/workflows/test.yaml)

CheckWarning.cmake is a [CMake](https://cmake.org) module that provides utility functions for checking compiler warnings during your project's build process. This module contains a `target_check_warning` function that helps in checking all recommended warnings on a given target.

## Integration

### Including the Script File

You can integrate this module into your project by including the [`target_check_warning.cmake`](./cmake/target_check_warning.cmake) file in your project.

```cmake
include(target_check_warning.cmake)
```

### Using CPM.cmake

Alternatively, you can use [CPM.cmake](https://github.com/cpm-cmake/CPM.cmake) to seamlessly integrate this module into your project.

```cmake
cpmaddpackage(gh:threeal/CheckWarning.cmake@1.2.0)
```

## Usage

### Checking Warnings on a Target

To enable all recommended warnings on a target and treat them as errors, use the `target_check_warning` function. This will cause the build process to fail when a warning is violated.

```cmake
add_executable(main main.cpp)
target_check_warning(main)
```

### Ignoring Specific Warnings

You can pass `FLAGS` to the `target_check_warning` function to ignore specific warnings on a target.

```cmake
target_check_warning(main FLAGS -Wno-unused-variable)
```

## License

This project is licensed under the terms of the [MIT License](./LICENSE).

Copyright © 2023 [Alfi Maulana](https://github.com/threeal)
