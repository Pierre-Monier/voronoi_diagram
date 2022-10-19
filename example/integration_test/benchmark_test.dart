import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'benchmark_robot.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('voronoi diagram benchmark\n', () {
    testWidgets(
      """
      Points: 10
      Size: 400x400
      Max Calculation time: 150ms
      """,
      (tester) async {
        final benchmarkRobot = BenchmarkRobot(tester);
        await benchmarkRobot.doBenchmark(
          diagramSize: const Size(400, 400),
          numberOfPoints: 10,
          maxCalculationTime: const Duration(milliseconds: 150),
        );
      },
    );
    testWidgets("""
      Points: 100
      Size: 400x400
      Max Calculation time: 150ms
      """, (tester) async {
      final benchmarkRobot = BenchmarkRobot(tester);
      await benchmarkRobot.doBenchmark(
        diagramSize: const Size(400, 400),
        numberOfPoints: 100,
        maxCalculationTime: const Duration(milliseconds: 150),
      );
    });

    testWidgets("""
      Points: 1000
      Size: 400x400
      Max Calculation time: 150ms
      """, (tester) async {
      final benchmarkRobot = BenchmarkRobot(tester);
      await benchmarkRobot.doBenchmark(
        diagramSize: const Size(400, 400),
        numberOfPoints: 1000,
        maxCalculationTime: const Duration(milliseconds: 150),
      );
    });

    testWidgets("""
      Points: 10000
      Size: 400x400
      Max Calculation time: 150ms
      """, (tester) async {
      final benchmarkRobot = BenchmarkRobot(tester);
      await benchmarkRobot.doBenchmark(
        diagramSize: const Size(400, 400),
        numberOfPoints: 10000,
        maxCalculationTime: const Duration(milliseconds: 150),
      );
    });
  });
}
