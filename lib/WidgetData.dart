import 'package:flutter/widgets.dart';

enum WidgetShape { Oval, Rect, RRect }

class WidgetData {
  final GlobalKey key;
  final WidgetShape shape;
  final bool isEnabled;
  final double padding;

  WidgetData({
    required this.key,
    this.shape = WidgetShape.Oval,
    this.isEnabled = true,
    this.padding = 0,
  });
}
