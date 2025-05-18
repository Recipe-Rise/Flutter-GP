import 'package:fitfork_gp/features/Home/data/models/sleep_model.dart';
import 'package:flutter/material.dart';

class HeartRateChart extends StatelessWidget {
  final List<HeartRatePoint> data;

  const HeartRateChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Heart Rate During Sleep',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 180,
          child: HeartRateChartPainter(data: data),
        ),
      ],
    );
  }
}

class HeartRateChartPainter extends StatelessWidget {
  final List<HeartRatePoint> data;

  const HeartRateChartPainter({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final minBpm =
    data.map((point) => point.bpm).reduce((a, b) => a < b ? a : b);
    final maxBpm =
    data.map((point) => point.bpm).reduce((a, b) => a > b ? a : b);

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                '${maxBpm.round()} bpm',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 4),
        Expanded(
          child: CustomPaint(
            size: Size.infinite,
            painter: _HeartRateChartCustomPainter(
              data: data,
              minBpm: minBpm,
              maxBpm: maxBpm,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            SizedBox(
              width: 40,
              child: Text(
                '${minBpm.round()} bpm',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '12AM',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(
              '3AM',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(
              '6AM',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(
              '9AM',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeartRateChartCustomPainter extends CustomPainter {
  final List<HeartRatePoint> data;
  final double minBpm;
  final double maxBpm;

  _HeartRateChartCustomPainter({
    required this.data,
    required this.minBpm,
    required this.maxBpm,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF6A3DE8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();

    final sortedData = List.of(data)..sort((a, b) => a.hour.compareTo(b.hour));

    if (sortedData.isEmpty) return;

    bool isFirstPoint = true;
    for (final point in sortedData) {
      final x = (point.hour / 12) * size.width;
      final normalizedY = (point.bpm - minBpm) / (maxBpm - minBpm);
      final y = size.height - (normalizedY * size.height);

      if (isFirstPoint) {
        path.moveTo(x, y);
        isFirstPoint = false;
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}