import 'dart:math';
import 'package:flutter/material.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: CustomPaint(
        painter: PieChartPainter(),
        child: const Center(
          child: SizedBox(
            height: 90,
            width: 90,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEEEEEE),
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final segments = [
      PieSegment(0.2, const Color(0xFF26A69A)),
      PieSegment(0.2, const Color(0xFFF06292)),
      PieSegment(0.2, const Color(0xFF42A5F5)),
      PieSegment(0.2, const Color(0xFF9575CD)),
      PieSegment(0.2, const Color(0xFFFFB74D)),
    ];

    double startAngle = 0;

    for (final segment in segments) {
      final sweepAngle = segment.percentage * 2 * pi;

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PieSegment {
  final double percentage;
  final Color color;

  PieSegment(this.percentage, this.color);
}
