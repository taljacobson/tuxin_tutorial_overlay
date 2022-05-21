
import 'package:flutter/material.dart';

import 'HoleArea.dart';
import 'WidgetData.dart';

final Color colorBlack = Colors.black.withOpacity(0.4);

class OverlayPainter extends CustomPainter {
  final Animation<double> animation;

  final BuildContext context;
  final List<HoleArea> areas = [];
  final List<WidgetData>? widgetsData;
  final Color bgColor;
  final double padding;

  OverlayPainter({
    required this.padding,
    required this.animation,
    required this.context,
    this.widgetsData,
    Color? bgColor,
  })  : this.bgColor = bgColor ?? colorBlack,
        super(repaint: animation) {
    if (widgetsData!.isNotEmpty) {
      widgetsData!.forEach((widgetData) {
        if (!widgetData.isEnabled) {
          final GlobalKey key = widgetData.key;
          if (key.currentWidget == null) {
            //throw new Exception("GlobalKey is not assigned to a Widget!");
          } else {
            areas.add(HoleArea.getHoleArea(
                key: key,
                padding: widgetData.padding,
                shape: widgetData.shape));
          }
        }
      });
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double animationValue = animation.value;
    Path path = Path()..addRect(Rect.fromLTWH(0, 0, screenWidth, screenHeight));

    areas.forEach((area) {
      switch (area.shape) {
        case WidgetShape.Oval:
          {
            path = Path.combine(
              PathOperation.difference,
              path,
              Path()
                ..addOval(
                  Rect.fromLTWH(
                    area.x -
                        (((area.padding + padding) + animationValue * 15) / 2),
                    area.y -
                        ((area.padding + padding) + animationValue * 15) / 2,
                    area.width +
                        ((area.padding + padding) + animationValue * 15),
                    area.height +
                        ((area.padding + padding) + animationValue * 15),
                  ),
                ),
            );
          }
          break;
        case WidgetShape.Rect:
          {
            path = Path.combine(
              PathOperation.difference,
              path,
              Path()
                ..addRect(
                  Rect.fromLTWH(
                    area.x -
                        (((area.padding + padding) + animationValue * 15) / 2),
                    area.y -
                        ((area.padding + padding) + animationValue * 15) / 2,
                    area.width +
                        ((area.padding + padding) + animationValue * 15),
                    area.height +
                        ((area.padding + padding) + animationValue * 15),
                  ),
                ),
            );
          }
          break;
        case WidgetShape.RRect:
          {
            path = Path.combine(
              PathOperation.difference,
              path,
              Path()
                ..addRRect(
                  RRect.fromRectAndCorners(
                    Rect.fromLTWH(
                        area.x -
                            (((area.padding + padding) + animationValue * 15) /
                                2),
                        area.y -
                            ((area.padding + padding) + animationValue * 15) /
                                2,
                        area.width +
                            ((area.padding + padding) + animationValue * 15),
                        area.height +
                            ((area.padding + padding) + animationValue * 15)),
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
            );
          }
          break;
      }
    });

    canvas.drawPath(path, Paint()..color = bgColor);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
