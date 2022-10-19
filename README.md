# voronoi_diagram

![voronoi_diagram](https://github.com/Pierre-Monier/voronoi_diagram/blob/main/screenshot/voronoi_diagram.png)

This repository is used to draw voronoi diagrams. You just have to pass sites point and the size of your diagram.

```dart
getVoronoiDiagram(sites: sites, diagramBound: diagramBound)
```

This return a `Future<List<List<Offset>>>`, each `List<Offset>` represent a voronoi cell. Then you can draw your voronoi diagram easily with a `CustomPainter`, e.g

```dart
for (final voronoiCell in voronoiDiagram) {
    canvas.drawPoints(
    PointMode.polygon,
    voronoiCell,
    Paint()
        ..color = Colors.red
        ..strokeWidth = 2,
    );
}
```

There is also a default `VoronoiDiagramPainter` to display the diagram on the screen. You can use it like this inside a `CustomPaint` widget :

```dart
CustomPaint(
        size: benchmarkData.diagramSize,
        painter: VoronoiDiagramPainter(
            generatorPoints: benchmarkData.generatorPoints,
            voronoiDiagram: data,
    ),
)
```


## Benchmark

It get the drawable voronoi diagram representation in **~115ms**, with **10000 sites** and a diagram **size of 400x400**

It's calculated in "real life" context, i.e in a flutter app

you can run the benchmark with the `benchmark.sh` script, in the example folder.

## How does it works ?

Dart code take inputs, then it use dart:ffi to calculate the voronoi diagram with the rust language, then the result is pass back to the dart side.

The rust side is using an implementation of the Fortune's algorithm. If you want to know more about this amazing topic, I recommand to read [this amazing article](https://jacquesheunis.com/post/fortunes-algorithm/)

## Contribution

To start working on the project, you must check the following.

To begin, ensure that you have a working installation of the following items:
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Rust language](https://rustup.rs/)
- Appropriate [Rust targets](https://rust-lang.github.io/rustup/cross-compilation.html) for cross-compiling to your device
- For Android targets:
    - Install [cargo-ndk](https://github.com/bbqsrc/cargo-ndk#installing)
    - Install Android NDK 22, then put its path in one of the `gradle.properties`, e.g.:

```
echo "ANDROID_NDK=.." >> ~/.gradle/gradle.properties
```

- [Web dependencies](http://cjycode.com/flutter_rust_bridge/template/setup_web.html) for the Web

Then go ahead and run `flutter run`! When you're ready, refer to our documentation
[here](https://fzyzcjy.github.io/flutter_rust_bridge/index.html)
to learn how to write and use binding code.
