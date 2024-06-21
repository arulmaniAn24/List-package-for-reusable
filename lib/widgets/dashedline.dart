import 'package:flutter/material.dart';

class VerticalDashedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;
  final double dashGap;

  const VerticalDashedLine({
    super.key,
    required this.height,
    this.color = Colors.black,
    this.dashWidth = 5.0,
    this.dashGap = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: _DashedLinePainter(color, dashWidth, dashGap),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Paint _paint;
  final double dashWidth;
  final double dashGap;

  _DashedLinePainter(Color color, this.dashWidth, this.dashGap)
      : _paint = Paint()
          ..color = color
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final double startX = size.width / 2;
    const double startY = -60;
    final double endY = size.height;

    double currentY = startY;

    while (currentY < endY) {
      canvas.drawLine(
        Offset(startX, currentY),
        Offset(startX, currentY + dashWidth),
        _paint,
      );
      currentY += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_DashedLinePainter oldDelegate) => false;
}
