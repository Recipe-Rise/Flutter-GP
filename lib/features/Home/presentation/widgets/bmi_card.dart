import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/BMI/presentation/views/detailed_bmi_screen.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BmiCard extends StatelessWidget {
  final double? bmi; // Make bmi optional

  const BmiCard({super.key, this.bmi});

  String _getWeightStatus(double bmi) {
    if (bmi < 18.5) {
      return "You have an underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "You have a normal weight";
    } else {
      return "You have an overweight";
    }
  }

  Color _getCardColor(double bmi) {
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
    final registerCubit = context.read<RegisterCubit>();
    final registerData = registerCubit.registerData;

    // Use provided BMI or calculate it from registerData
    final calculatedBmi = bmi ?? registerCubit.calculateBMI();

    return Card(
      color: _getCardColor(calculatedBmi),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "BMI (Body Mass Index)",
              style: Styles.textStyle18.copyWith(color: Colors.white),
            ),
            const SizedBox(
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
                        _getWeightStatus(calculatedBmi),
                        style: Styles.textStyle16.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomGradientButton(
                        onPressed: () {
                          // Calculate age from date of birth
                          final age = DateTime.now().year -
                              registerData.dateOfBirth.year;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailedBmiScreen(
                                bmi: calculatedBmi,
                                weight: registerData.weight,
                                height: registerData.height,
                                age: age,
                                gender: registerData.gender,
                              ),
                            ),
                          );
                        },
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
                  percent: calculatedBmi / 40 > 1 ? 1 : calculatedBmi / 40,
                  center: Text(
                    "${calculatedBmi.toStringAsFixed(1)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  progressColor: const Color(0xff4593F9),
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
