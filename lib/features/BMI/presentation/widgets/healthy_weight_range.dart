import 'package:flutter/material.dart';

class HealthyWeightRange extends StatelessWidget {
  final String height;

  const HealthyWeightRange({
    Key? key,
    required this.height,
  }) : super(key: key);

  double _getHealthyMinWeight() {
    final heightInMeters = double.parse(height) / 100;
    return 18.5 * heightInMeters * heightInMeters;
  }

  double _getHealthyMaxWeight() {
    final heightInMeters = double.parse(height) / 100;
    return 24.9 * heightInMeters * heightInMeters;
  }

  @override
  Widget build(BuildContext context) {
    final minWeight = _getHealthyMinWeight();
    final maxWeight = _getHealthyMaxWeight();

    return Column(
      children: [
        const Text(
          'Healthy weight for the height:',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${minWeight.toStringAsFixed(1)} kg - ${maxWeight.toStringAsFixed(1)} kg',
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
