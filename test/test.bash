#!/usr/bin/env bash

root="$(cd "$(dirname "$0")" && pwd)"
for dir in $root/*/ ; do
  echo ::group::testing $(realpath --relative-to=$root $dir)...
  cmake "$dir" -B "$dir/build" -D GIT_COMMIT=$(git rev-parse --short HEAD)
  echo ::endgroup::
done
