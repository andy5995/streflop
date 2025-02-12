#!/bin/bash
# TODO: make this script POSIX compliant (bash should not be required).

set -e

# Define build configurations
configs=(
    "sse false"
    "sse true"
    "x87 false"
    "x87 true"
    "soft true"
)

for config in "${configs[@]}"; do
    read -r fpu denormals <<< "$config"

    build_dir="build_${fpu}_denormals_${denormals}"

    # reconfigure if the directory already exists
    if [ -d "$build_dir" ]; then
        meson setup --reconfigure "$build_dir" -D fpu="$fpu" -D denormals="$denormals" --buildtype=release
    else
        meson setup "$build_dir" -D fpu="$fpu" -D denormals="$denormals" --buildtype=release
    fi

    ninja -C "$build_dir"
    meson test -C "$build_dir"
done
