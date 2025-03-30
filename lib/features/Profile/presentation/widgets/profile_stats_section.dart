import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_stat_item.dart';
import 'package:fitfork_gp/features/Register/data/Models/register_data.dart';
import 'package:flutter/material.dart';

class ProfileStatsSection extends StatelessWidget {
  final RegisterData userData;
  final double bmi;
  final double bmr;
  const ProfileStatsSection(
      {super.key,
      required this.userData,
      required this.bmi,
      required this.bmr});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatContainer(
          child: ProfileStatItem(
            value: "${userData.height.toInt()}cm",
            label: "Height",
          ),
        ),
        StatContainer(
          child: ProfileStatItem(
            value: "${userData.weight.toInt()}kg",
            label: "Weight",
          ),
        ),
        StatContainer(
          child: ProfileStatItem(
            value: "${DateTime.now().year - userData.dateOfBirth.year}yo",
            label: "Age",
          ),
        ),
      ],
    );
  }
}

class StatContainer extends StatelessWidget {
  final Widget child;
  const StatContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
