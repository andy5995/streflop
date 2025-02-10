#!/bin/sh

meson setup _build \
  -Dfpu=sse -Dno_denormals=true -Db_sanitize=address,undefined -Db_lundef=false
