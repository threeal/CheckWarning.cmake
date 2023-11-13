#!/usr/bin/env bash

root=$(cd $(dirname $0) && pwd)

echo '::group::Preparing for warning check testing...'
cmake $root -B $root/build
if [ $? -ne 0 ]; then
  echo '::error::Failed to configure the project.'
  echo '::endgroup::'
  exit 1
fi
echo '::endgroup::'

let fails=0

echo '::group::Testing warning check for success...'
cmake --build $root/build --target correct
if [ $? -ne 0 ]; then
  echo '::error::The build for the correct target should succeed.'
  let fails++
fi
echo ::endgroup::

echo '::group::Testing warning check for failure...'
cmake --build $root/build --target incorrect
if [ $? -eq 0 ]; then
  echo '::error::The build for the incorrect target should fail.'
  let fails++
fi
echo '::endgroup::'

echo '::group::Testing warning check with additional parameters...'
cmake --build $root/build --target with_parameters
if [ $? -ne 0 ]; then
  echo '::error::The build for the with_parameters target should succeed.'
  let fails++
fi
echo '::endgroup::'

echo '::group::Testing warning check for success in C...'
cmake --build $root/build --target correct_c
if [ $? -ne 0 ]; then
  echo '::error::The build for the correct_c target should succeed.'
  let fails++
fi
echo ::endgroup::

echo '::group::Testing warning check for failure in C...'
cmake --build $root/build --target incorrect_c
if [ $? -eq 0 ]; then
  echo '::error::The build for the incorrect_c target should fail.'
  let fails++
fi
echo '::endgroup::'

echo '::group::Testing warning check with additional parameters in C...'
cmake --build $root/build --target with_parameters_c
if [ $? -ne 0 ]; then
  echo '::error::The build for the with_parameters_c target should succeed.'
  let fails++
fi
echo '::endgroup::'

if [ $fails -gt 0 ]; then
  exit 1
fi
