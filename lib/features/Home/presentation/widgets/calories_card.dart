import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';

class CaloriesCard extends StatelessWidget {
  final double bmr;
  final double consumedCalories;

  const CaloriesCard({
    super.key,
    required this.bmr,
    required this.consumedCalories,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final double remainingCalories = bmr - consumedCalories;
    final double completionPercentage =
        (consumedCalories / bmr).clamp(0.0, 1.0);

    final double cardPadding = screenSize.width * 0.05;
    final double progressSize = screenSize.width * 0.28;
    final double progressThickness = screenSize.width * 0.03;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Calories",
              style: Styles.textStyle18.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: screenSize.width * 0.045,
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Text(
              "${bmr.toInt()} kCal",
              style: TextStyle(
                fontSize: screenSize.width * 0.07,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF96B2FE),
              ),
            ),
            SizedBox(height: screenSize.height * 0.02),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: progressSize,
                    height: progressSize,
                    child: CircularProgressIndicator(
                      value: completionPercentage,
                      strokeWidth: progressThickness,
                      backgroundColor: Colors.grey.shade200,
                      valueColor:
                          const AlwaysStoppedAnimation(Color(0xFF96B2FE)),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${remainingCalories.toInt()}kCal",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF96B2FE),
                        ),
                      ),
                      Text(
                        "left",
                        style: TextStyle(
                          fontSize: screenSize.width * 0.035,
                          color: const Color(0xFF96B2FE),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
