#!/usr/bin/env bash

root=$(cd $(dirname $0) && pwd)

let fails=0
for script in $(find $root -iname test.bash) ; do
  dir=$(dirname $script)
  name=$(realpath --relative-to=$root $dir)
  echo ::group::testing $name...
  $script
  if [ $? -ne 0 ]; then
    echo ::error::$name test failed
    let fails++
  fi
  echo ::endgroup::
done

if [ $fails -gt 0 ]; then
  exit 1
fi
