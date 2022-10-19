// ignore_for_file: avoid_print

import 'dart:math' hide log;

import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/flutter_rust_bridge_template.dart';
import 'package:flutter_test/flutter_test.dart';

import 'voronoi_custom_paint.dart';

class BenchmarkRobot {
  const BenchmarkRobot(this.tester);

  final WidgetTester tester;

  Future<void> doBenchmark({
    required Size diagramSize,
    required int numberOfPoints,
    required Duration maxCalculationTime,
  }) async {
    final calculationTimer = Stopwatch();

    final generatorPoints = _getGeneratorPoints(
      numberOfPoints: 10,
      size: diagramSize,
    );

    void onFutureCompleted() {
      calculationTimer.stop();
    }

    void onFutureStart() {
      calculationTimer.start();
    }

    final benchmarkData = BenchmarkData(
      generatorPoints: generatorPoints,
      diagramSize: diagramSize,
      voronoiFuture:
          getVoronoiDiagram(sites: generatorPoints, diagramBound: diagramSize),
      onFutureStart: onFutureStart,
      onFutureCompleted: onFutureCompleted,
    );

    await tester.pumpWidget(BenchmarkApp(benchmarkData: benchmarkData));
    await tester.pumpAndSettle();

    print('Calculation takes: ${calculationTimer.elapsedMilliseconds}ms');

    expect(
        calculationTimer.elapsedMilliseconds <
            maxCalculationTime.inMilliseconds,
        true);
  }

  List<Offset> _getGeneratorPoints({
    required int numberOfPoints,
    required Size size,
  }) {
    final points = <Offset>[];

    for (var i = 0; i < numberOfPoints; i++) {
      points.add(
        Offset(
          (Random().nextDouble() * size.width).roundToDouble(),
          (Random().nextDouble() * size.height).roundToDouble(),
        ),
      );
    }

    return points;
  }
}
