#!/bin/bash

# This script builds the native library for Android.
# You must have a define $ANDROID_NDK_HOME environment variable.

get_target() {
    if [ "$1" = "sim" ]; then
        TARGET="aarch64-apple-ios-sim"
    elif [ "$1" = "x86" ]; then
        TARGET="x86_64-apple-ios"
    else
        TARGET="aarch64-apple-ios"
    fi
}


build() {
    LIBNAME="voronoi_diagram"
    echo "Building ios libs"

    get_target $1
    cd native
    rustup target add $TARGET

    cargo build --target $TARGET --release
    mv "target/$TARGET/release/lib$LIBNAME.a" "../ios/libs/$TARGET/lib$LIBNAME.a"
}

build $1