#!/usr/bin/env bash

root=$(cd $(dirname $0) && pwd)

let fails=0
for script in $(find $root -iname test.bash) ; do
  $script
  if [ $? -ne 0 ]; then
    let fails++
  fi
done

if [ $fails -gt 0 ]; then
  exit 1
fi
