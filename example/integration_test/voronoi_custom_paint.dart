import 'package:flutter/material.dart';

import 'package:voronoi_diagram/src/voronoi_painter.dart';

class BenchmarkApp extends StatelessWidget {
  const BenchmarkApp({Key? key, required this.benchmarkData}) : super(key: key);

  final BenchmarkData benchmarkData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(benchmarkData: benchmarkData),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.benchmarkData}) : super(key: key);
  final BenchmarkData benchmarkData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VoronoiCustomPainter(benchmarkData: benchmarkData),
    );
  }
}

class VoronoiCustomPainter extends StatelessWidget {
  const VoronoiCustomPainter({
    super.key,
    required this.benchmarkData,
  });

  final BenchmarkData benchmarkData;

  @override
  Widget build(BuildContext context) {
    benchmarkData.onFutureStart();
    return FutureBuilder<List<List<Offset>>>(
      future: benchmarkData.voronoiFuture,
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null) {
          return const CircularProgressIndicator();
        }

        benchmarkData.onFutureCompleted();
        return CustomPaint(
          size: benchmarkData.diagramSize,
          painter: VoronoiDiagramPainter(
            generatorPoints: benchmarkData.generatorPoints,
            voronoiDiagram: data,
          ),
        );
      },
    );
  }
}

class BenchmarkData {
  BenchmarkData({
    required this.generatorPoints,
    required this.voronoiFuture,
    required this.diagramSize,
    required this.onFutureCompleted,
    required this.onFutureStart,
  });

  final Future<List<List<Offset>>> voronoiFuture;
  final List<Offset> generatorPoints;
  final Size diagramSize;
  final VoidCallback onFutureCompleted;
  final VoidCallback onFutureStart;
}
