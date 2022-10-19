#!/bin/bash

# This script builds the native library for Android.
# You must have a define $ANDROID_NDK_HOME environment variable.
LIBNAME="voronoi_diagram"

get_target() {
    if [ "$1" = "armeabi" ]; then
        TARGET="armeabi-v7a"
    else
        TARGET="arm64-v8a"
    fi
}

build() {
    # prepare_build
    # COMPILER_DIR="$NDK/toolchains/llvm/prebuilt/$NDK_HOST_TAG/bin"
    echo "Building android libs"

    get_target $1
    
    cd native
    rustup target add $TARGET
    # cargo build --target $TARGET --release
    cargo ndk -t $TARGET -o "../android/libs" build --release
}


build $1