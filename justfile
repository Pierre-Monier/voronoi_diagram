default: gen build lint

gen:
    flutter pub get
    flutter_rust_bridge_codegen \
        --rust-input native/src/api.rs \
        --dart-output lib/src/bridge_generated.dart \
        --c-output ios/Classes/bridge_generated.h \
        --c-output macos/Classes/bridge_generated.h \
        --dart-decl-output lib/src/bridge_definitions.dart

build:
    ./script/build_macos.sh
    ./script/build_ios.sh
    ./script/build_android.sh armeabi
    ./script/build_android.sh arm64

lint:
    cd native && cargo fmt
    dart format .

clean:
    flutter clean
    cd native && cargo clean
