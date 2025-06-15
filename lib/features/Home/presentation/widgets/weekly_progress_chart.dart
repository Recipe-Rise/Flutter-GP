import 'package:flutter/material.dart';

class WeeklyProgressChart extends StatelessWidget {
  final List<double> weeklyData;
  final double goalValue;

  const WeeklyProgressChart({
    Key? key,
    required this.weeklyData,
    required this.goalValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Goal line
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Text(
                'Goal',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.orange.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),

        // Bar chart (use Flexible height safely)
        Flexible(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double barWidth = constraints.maxWidth / (weeklyData.length * 2.5);
              final double maxHeight = constraints.maxHeight - 30;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(weeklyData.length, (index) {
                  final double normalizedHeight = (weeklyData[index] / goalValue).clamp(0.0, 1.0);
                  final Color barColor = weeklyData[index] >= goalValue
                      ? Colors.blue
                      : Colors.blue.withOpacity(0.6);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: barWidth,
                        height: normalizedHeight * maxHeight,
                        decoration: BoxDecoration(
                          color: barColor,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        days[index],
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
