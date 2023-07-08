#!/usr/bin/env bash

root=$(cd $(dirname $0) && pwd)

echo ::group::Preparing for warning check testing...
cmake $root -B $root/build
if [ $? -ne 0 ]; then
  echo ::error::Failed to configure the project.
  echo ::endgroup::
  exit 1
fi
echo ::endgroup::

let fails=0

echo ::group::Testing warning check for success...
cmake --build $root/build --target correct
if [ $? -ne 0 ]; then
  echo ::error::The build for the correct target should succeed.
  let fails++
fi
echo ::endgroup::

echo ::group::Testing warning check for failure...
cmake --build $root/build --target incorrect
if [ $? -eq 0 ]; then
  echo ::error::The build for the incorrect target should fail.
  let fails++
fi
echo ::endgroup::

if [ $fails -gt 0 ]; then
  exit 1
fi
