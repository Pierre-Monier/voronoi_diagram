import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge_template/src/ffi.dart';

Future<List<List<Offset>>> getVoronoiDiagram(
    {required List<Offset> sites, required Size diagramBound}) async {
  final pointsData =
      sites.map((e) => jsonEncode({"x": e.dx, "y": e.dy})).toList();
  final boxSize =
      jsonEncode({"width": diagramBound.width, "height": diagramBound.height});

  final voronoiDiagramData =
      await api.getVoronoi(points: pointsData, boxsize: boxSize);

  final voronoiDiagram = voronoiDiagramData
      .map((e) => e.map((pointData) {
            final point = jsonDecode(pointData) as Map<String, dynamic>;
            return Offset(point['x'] as double, point['y'] as double);
          }).toList())
      .toList();

  return voronoiDiagram;
}
