#!/usr/bin/env bash

root="$(cd "$(dirname "$0")" && pwd)"

let fails=0
for dir in $root/*/ ; do
  name=$(realpath --relative-to=$root $dir)
  echo ::group::testing $name...
  "$dir/test.bash"
  if [ $? -ne 0 ]; then
    echo ::error::$name test failed
    let fails++
  fi
  echo ::endgroup::
done

if [ $fails -gt 0 ]; then
  exit 1
fi
