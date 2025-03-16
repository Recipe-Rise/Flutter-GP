import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/activity_status_header.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/bmi_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/water_intake_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final String firstName;
  final double bmi;
  final double bmr;
  const HomeScreen(
      {super.key,
      required this.firstName,
      required this.bmi,
      required this.bmr});

  @override
  Widget build(BuildContext context) {
    final waterIntakeUpdates = [
      {"time": "6am - 8am", "amount": "600"},
      {"time": "9am - 11am", "amount": "500"},
      {"time": "11am - 2pm", "amount": "1000"},
      {"time": "2pm - 4pm", "amount": "700"},
      {"time": "4pm - now", "amount": "900"},
    ];
    int totalWaterIntake = 0;
    for (var update in waterIntakeUpdates) {
      totalWaterIntake += int.parse(update["amount"]!);
    }

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome Back,",
                  style: Styles.textStyle16.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                Icon(
                  FontAwesomeIcons.bell,
                  size: 18,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "$firstName",
              style: Styles.textStyle30,
            ),
            SizedBox(
              height: 16,
            ),
            BmiCard(bmi: bmi),
            const SizedBox(height: 24),
            const ActivityStatusHeader(),
            WaterIntakeCard(
              waterIntakeInML: totalWaterIntake,
              timeUpdates: waterIntakeUpdates,
            ),
          ],
        ),
      )),
    );
  }
}
