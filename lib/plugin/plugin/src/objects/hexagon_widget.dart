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
          Positioned(
            top: -10,
            left: element.size.width / 2 - 10, // Adjust position of top connection point
            child: ConnectionPoint(),
          ),
          Positioned(
            bottom: -10,
            left: element.size.width / 2 - 10, // Adjust position of bottom connection point
            child: ConnectionPoint(),
          ),
        ],
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  static const int numSides = 6;

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

    final double rotationAngle = math.pi / 6; // 45-degree angle in radians

    // Apply rotation transformation
    canvas.translate(centerX, centerY);
    canvas.rotate(rotationAngle);
    canvas.translate(-centerX, -centerY);

    path.moveTo(centerX + sideLength * math.cos(0), centerY + sideLength * math.sin(0));
    for (int i = 1; i <= numSides; i++) {
      final double theta = 2.0 * math.pi / numSides * i;
      final double x = centerX + sideLength * math.cos(theta);
      final double y = centerY + sideLength * math.sin(theta);
      path.lineTo(x, y);
    }
    path.close();

    if (element.elevation > 0.01) {
      canvas.drawShadow(
        path.shift(Offset(element.elevation, element.elevation)),
        element.borderColor,
        element.elevation,
        true,
      );
    }
    canvas.drawPath(path, paint);

    paint.strokeWidth = element.borderThickness;
    paint.color = element.borderColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ConnectionPoint extends StatelessWidget {
  final double pointSize = 20.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle connection point tap here
        // You can add your own logic to connect this point to another shape
        print('Connection point tapped');
      },
      child: Container(
        width: pointSize,
        height: pointSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}
