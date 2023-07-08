#!/usr/bin/env bash

root=$(cd $(dirname $0) && pwd)

cmake $root -B $root/build
if [ $? -ne 0 ]; then
  echo ::error::Failed to configure the project!
  exit 1
fi

let fails=0

cmake --build $root/build --target correct
if [ $? -ne 0 ]; then
  echo ::error::Build for target correct should be success!
  let fails++
fi

cmake --build $root/build --target incorrect
if [ $? -eq 0 ]; then
  echo ::error::Build for target incorrect should be failed!
  let fails++
fi

if [ $fails -gt 0 ]; then
  exit 1
fi
