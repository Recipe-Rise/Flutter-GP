import 'package:flutter/material.dart';

class ProgressIndicatorBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProgressIndicatorBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        bool isCompleted = index < currentStep;
        bool isCurrent = index == currentStep;

        return Expanded(
          child: Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isCompleted || isCurrent
                  ? Colors.green
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
