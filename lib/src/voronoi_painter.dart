import 'dart:ui';

import 'package:flutter/material.dart';

class VoronoiDiagramPainter extends CustomPainter {
  const VoronoiDiagramPainter({
    required this.generatorPoints,
    required this.voronoiDiagram,
    this.backgroundColor = Colors.grey,
    this.cellColor = Colors.red,
    this.siteColor = Colors.black,
    this.drawSites = true,
    this.siteStrokeWidth = 10.0,
    this.cellStrokeWidth = 2.0,
  });

  final List<Offset> generatorPoints;
  final List<List<Offset>> voronoiDiagram;
  final Color backgroundColor;
  final Color cellColor;
  final Color siteColor;
  final bool drawSites;
  final double siteStrokeWidth;
  final double cellStrokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
      Paint()..color = backgroundColor,
    );

    if (drawSites) {
      canvas.drawPoints(
        PointMode.points,
        generatorPoints,
        Paint()
          ..strokeWidth = siteStrokeWidth
          ..color = siteColor,
      );
    }

    for (final voronoiCell in voronoiDiagram) {
      canvas.drawPoints(
        PointMode.polygon,
        voronoiCell,
        Paint()
          ..color = cellColor
          ..strokeWidth = cellStrokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
