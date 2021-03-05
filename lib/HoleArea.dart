import 'package:flutter/material.dart';
import 'WidgetData.dart';

class HoleArea {
  final double x, y, width, height, padding;
  final WidgetShape shape;
  HoleArea({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.padding,
    this.shape = WidgetShape.Oval,
  });
  factory HoleArea.getHoleArea({
    required GlobalKey key,
    double padding = 0.0,
    WidgetShape shape = WidgetShape.Oval,
  }) {
    final RenderBox renderBoxRed = key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBoxRed.localToGlobal(Offset.zero);
    final Size size = renderBoxRed.size;
    return HoleArea(
      height: size.height,
      width: size.width,
      x: position.dx,
      y: position.dy,
      shape: shape,
      padding: padding,
    );
  }
}
