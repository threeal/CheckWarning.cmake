#!/usr/bin/env bash

set -e

root="$(cd "$(dirname "$0")" && pwd)"

cmake "$root" -B "$root/build"
