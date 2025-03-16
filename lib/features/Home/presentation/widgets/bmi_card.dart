import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BmiCard extends StatelessWidget {
  final double bmi;
  const BmiCard({super.key, required this.bmi});
  String _getWeightStatus() {
    if (bmi < 18.5) {
      return "You have an underweight";
    } else if (bmi > 18.5 && bmi < 25) {
      return "You have a normal weight";
    } else {
      return "You have an overweight";
    }
  }

  Color _getCardColor() {
    if (bmi < 18.5) {
      return const Color(0xff96B2FE);
    } else if (bmi >= 18.5 && bmi < 25) {
      return const Color(0xff66B2FE);
    } else {
      return const Color(0xffFF9696);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getCardColor(),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "BMI (Body Mass Index)",
              style: Styles.textStyle18.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getWeightStatus(),
                        style: Styles.textStyle16.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      CustomGradientButton(
                        onPressed: () {},
                        gradient: kButtonColor,
                        text: "View More",
                        width: 100,
                        height: 36,
                        borderRadius: 20,
                      ),
                    ],
                  ),
                ),
                CircularPercentIndicator(
                  radius: 40,
                  lineWidth: 12,
                  percent: bmi / 40 > 1 ? 1 : bmi / 40,
                  center: Text(
                    "${bmi.toStringAsFixed(1)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  progressColor: Color(0xff4593F9),
                  backgroundColor: Colors.white.withOpacity(0.5),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
