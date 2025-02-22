#!/bin/sh

set -e

if [ -z "$MESON_CURRENT_BUILD_DIR" ]; then
  echo "This script used by Meson for testing."
fi

cd "$MESON_CURRENT_BUILD_DIR"
md5sum --warn --check "$MESON_CURRENT_SOURCE_DIR/$MESON_TEST.md5"
