import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/BMI/presentation/widgets/action_button.dart';
import 'package:fitfork_gp/features/BMI/presentation/widgets/bmi_result_card.dart';
import 'package:fitfork_gp/features/BMI/presentation/widgets/bmi_scale.dart';
import 'package:fitfork_gp/features/BMI/presentation/widgets/healthy_weight_range.dart';
import 'package:fitfork_gp/features/BMI/presentation/widgets/user_metrics_row.dart';
import 'package:flutter/material.dart';

class DetailedBmiScreen extends StatelessWidget {
  final double bmi;
  final String weight;
  final String height;
  final int age;
  final String gender;

  const DetailedBmiScreen(
      {super.key,
      required this.bmi,
      required this.weight,
      required this.height,
      required this.age,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            // Text(
            //   'Please Modify the values',
            //   style: Styles.textStyle16
            //       .copyWith(color: Colors.black.withOpacity(0.6)),
            // ),
            const SizedBox(
              height: 20,
            ),
            BmiResultCard(
              bmi: bmi,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  BmiScale(bmi: bmi),
                  const SizedBox(
                    height: 20,
                  ),
                  UserMetricsRow(
                    weight: weight,
                    height: height,
                    age: age,
                    gender: gender,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  HealthyWeightRange(height: height),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ActionButton(
              label: "Close",
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
