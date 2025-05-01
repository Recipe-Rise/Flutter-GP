import 'package:fitfork_gp/features/Home/data/models/sleep_model.dart';
import 'package:flutter/material.dart';

class WeeklySleepChart extends StatelessWidget {
  final List<DailySleep> data;
  final VoidCallback onSetGoal;

  const WeeklySleepChart({
    super.key,
    required this.data,
    required this.onSetGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Weekly Sleep',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            ElevatedButton(
              onPressed: onSetGoal,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A3DE8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Set Goal'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: data.map((dailySleep) {
              return _DailySleepBar(
                day: dailySleep.day,
                hours: dailySleep.hours,
                maxHours: 10,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _DailySleepBar extends StatelessWidget {
  final String day;
  final double hours;
  final double maxHours;

  const _DailySleepBar({
    required this.day,
    required this.hours,
    required this.maxHours,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedHeight = (hours / maxHours) * 120;

    final color = hours > 8
        ? const Color(0xFF6A3DE8)
        : hours > 6
            ? const Color(0xFF9E7BEA)
            : const Color(0xFFC7B5F3);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: normalizedHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
