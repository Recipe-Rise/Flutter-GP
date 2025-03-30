import 'package:flutter/material.dart';

class BmiResultCard extends StatelessWidget {
  final double bmi;
  final Widget child;

  const BmiResultCard({
    Key? key,
    required this.bmi,
    required this.child,
  }) : super(key: key);

  String _getBmiCategory() {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Normal";
    } else if (bmi >= 25 && bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  Color _getBmiColor() {
    if (bmi < 18.5) {
      return Colors.blue;
    } else if (bmi >= 18.5 && bmi < 25) {
      return Colors.green;
    } else if (bmi >= 25 && bmi < 30) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Your BMI:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            bmi.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: _getBmiColor(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: _getBmiColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getBmiCategory(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
