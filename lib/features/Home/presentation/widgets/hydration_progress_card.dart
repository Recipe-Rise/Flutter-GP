import 'package:flutter/material.dart';

class HydrationProgressCard extends StatelessWidget {
  final double currentIntake;
  final double goalIntake;
  final int glassesNeeded;

  const HydrationProgressCard({
    Key? key,
    required this.currentIntake,
    required this.goalIntake,
    required this.glassesNeeded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percentage = (currentIntake / goalIntake * 100).toInt();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildCircularProgress(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Hydration",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "$percentage% of your goal",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$glassesNeeded more glasses needed",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${currentIntake.toStringAsFixed(1)}/${goalIntake.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              "Liters",
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
