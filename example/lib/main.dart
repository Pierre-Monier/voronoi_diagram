import 'dart:math';

import 'package:flutter/material.dart';
import 'package:voronoi_diagram/voronoi_diagram.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

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

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;
    final generatorPoints =
        _getGeneratorPoints(numberOfPoints: 10, size: screenSize);

    return Scaffold(
      body: Center(
          child: FutureBuilder<List<List<Offset>>>(
        future:
            getVoronoiDiagram(sites: generatorPoints, diagramBound: screenSize),
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return const CircularProgressIndicator();
          }

          return CustomPaint(
            size: screenSize,
            painter: VoronoiDiagramPainter(
              generatorPoints: generatorPoints,
              voronoiDiagram: data,
            ),
          );
        },
      )),
    );
  }
}

extension on BuildContext {
  Size get screenSize =>
      Size(MediaQuery.of(this).size.width, MediaQuery.of(this).size.height);
}
