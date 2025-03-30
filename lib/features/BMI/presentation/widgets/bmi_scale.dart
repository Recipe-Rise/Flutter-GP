import 'package:flutter/material.dart';

class BmiScale extends StatelessWidget {
  final double bmi;

  const BmiScale({
    Key? key,
    required this.bmi,
  }) : super(key: key);

  String _getCategory() {
    if (bmi < 18.5) {
      return "underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "normal";
    } else if (bmi >= 25 && bmi < 30) {
      return "overweight";
    } else {
      return "obese";
    }
  }

  @override
  Widget build(BuildContext context) {
    final category = _getCategory();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 8; i++)
          _buildSegment(Colors.blue, category == "underweight"),
        for (int i = 0; i < 10; i++)
          _buildSegment(Colors.green, category == "normal"),
        for (int i = 0; i < 7; i++)
          _buildSegment(Colors.amber, category == "overweight"),
        for (int i = 0; i < 7; i++)
          _buildSegment(Colors.red, category == "obese"),
      ],
    );
  }

  Widget _buildSegment(Color color, bool isActive) {
    return Container(
      width: 6,
      height: 16,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
