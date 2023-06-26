import 'package:flutter/material.dart';

import '../elements/flow_element.dart';
import 'element_text_widget.dart';

/// A kind of element
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
  final FlowElement element;

  _HexagonPainter({
    required this.element,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    Path path = Path();

    paint.strokeJoin = StrokeJoin.round;

    paint.style = PaintingStyle.fill;
    paint.color = element.backgroundColor;

    final double sideLength = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    path.moveTo(centerX + sideLength * 0.5, centerY - sideLength * 0.866);
    path.lineTo(centerX + sideLength, centerY);
    path.lineTo(centerX + sideLength * 0.5, centerY + sideLength * 0.866);
    path.lineTo(centerX - sideLength * 0.5, centerY + sideLength * 0.866);
    path.lineTo(centerX - sideLength, centerY);
    path.lineTo(centerX - sideLength * 0.5, centerY - sideLength * 0.866);
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
