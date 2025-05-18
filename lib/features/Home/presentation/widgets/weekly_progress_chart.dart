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

    return Column(
      children: [
        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                'Goal',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.orange.withOpacity(0.5),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double barWidth =
                  constraints.maxWidth / (weeklyData.length * 2);
              final double maxHeight =
                  constraints.maxHeight - 30; // Space for labels

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(weeklyData.length, (index) {
                  final double normalizedHeight =
                  (weeklyData[index] / goalValue).clamp(0.0, 1.0);
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
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        days[index],
                        style: TextStyle(
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