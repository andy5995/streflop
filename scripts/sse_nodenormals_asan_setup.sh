#!/bin/sh

meson setup _build \
  -Dfpu=sse -Ddenormals=false -Db_sanitize=address,undefined -Db_lundef=false
