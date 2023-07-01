import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../elements/flow_element.dart';
import 'element_text_widget.dart';

class HexagonWidget extends StatelessWidget {
  final FlowElement element;

  const HexagonWidget({
    Key? key,
    required this.element,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: element.size.width,
      height: element.size.height,
      child: Stack(
        children: [
          CustomPaint(
            size: element.size,
            painter: _HexagonPainter(
              element: element,
            ),
          ),
          ElementTextWidget(element: element),
        ],
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  static const int numSides = 6;
  static const int numConnectionPoints = 6;

  final FlowElement element;

  _HexagonPainter({
    required this.element,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final Path path = Path();

    paint.strokeJoin = StrokeJoin.round;
    paint.style = PaintingStyle.fill;
    paint.color = element.backgroundColor;

    final double sideLength = math.min(size.width, size.height) / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    path.moveTo(centerX + sideLength * math.cos(0), centerY + sideLength * math.sin(0));
    for (int i = 1; i <= numSides; i++) {
      final double theta = 2.0 * math.pi / numSides * i;
      final double x = centerX + sideLength * math.cos(theta);
      final double y = centerY + sideLength * math.sin(theta);
      path.lineTo(x,y);
    }
    path.close();

    if (element.elevation > 0.01) {
      canvas.drawShadow(
        path.shift(Offset(element.elevation, element.elevation)),
        Colors.black,
        element.elevation,
        true,
      );
    }
    canvas.drawPath(path, paint);

    paint.strokeWidth = element.borderThickness;
    paint.color = element.borderColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);

    // Draw connection points
    final List<Offset> connectionPoints = [];
    final double connectionRadius = 5.0;
    final double connectionAngle = 2.0 * math.pi / numConnectionPoints;

    for (int i = 0; i < numConnectionPoints; i++) {
      final double theta = connectionAngle * i;
      final double x = centerX + sideLength * math.cos(theta);
      final double y = centerY + sideLength * math.sin(theta);
      connectionPoints.add(Offset(x, y));
      canvas.drawCircle(Offset(x, y), connectionRadius, Paint()..color = Colors.black);
    }

    // Draw connection lines
    final double connectionLineThickness = 1.0;
    final Paint connectionLinePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = connectionLineThickness;

    for (int i = 0; i < connectionPoints.length; i++) {
      final Offset startPoint = connectionPoints[i];
      final Offset endPoint = connectionPoints[(i + 1) % numConnectionPoints];
      canvas.drawLine(startPoint, endPoint, connectionLinePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
