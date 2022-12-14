// This file initializes the dynamic library and connects it with the stub
// generated by flutter_rust_bridge_codegen.

import 'dart:ffi';

import 'bridge_generated.dart';
import 'bridge_definitions.dart';
export 'bridge_definitions.dart';

// Re-export the bridge so it is only necessary to import this file.
export 'bridge_generated.dart';
import 'dart:io' as io;

const _base = 'voronoi_diagram';

final _dylib = io.Platform.isWindows
    ? '$_base.dll'
    : io.Platform.isMacOS
        ? 'lib$_base.dylib'
        : 'lib$_base.so';

final VoronoiDiagram api = VoronoiDiagramImpl(io.Platform.isIOS
    ? DynamicLibrary.executable()
    : DynamicLibrary.open(_dylib));
