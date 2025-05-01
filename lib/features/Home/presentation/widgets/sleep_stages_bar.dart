import 'package:flutter/material.dart';

class SleepStagesBar extends StatelessWidget {
  final double awakePercentage;
  final double lightPercentage;
  final double deepPercentage;
  final double remPercentage;

  const SleepStagesBar({
    super.key,
    required this.awakePercentage,
    required this.lightPercentage,
    required this.deepPercentage,
    required this.remPercentage,
  }) : assert(awakePercentage +
                lightPercentage +
                deepPercentage +
                remPercentage <=
            1.0);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 10,
        child: Row(
          children: [
            _buildStageSegment(
                Colors.white70.withOpacity(0.4), awakePercentage),
            _buildStageSegment(
                Colors.white70.withOpacity(0.5), lightPercentage),
            _buildStageSegment(Colors.white70.withOpacity(0.7), deepPercentage),
            _buildStageSegment(Colors.white70.withOpacity(0.9), remPercentage),
          ],
        ),
      ),
    );
  }

  Widget _buildStageSegment(Color color, double percentage) {
    return Expanded(
      flex: (percentage * 100).round(),
      child: Container(
        color: color,
      ),
    );
  }
}
