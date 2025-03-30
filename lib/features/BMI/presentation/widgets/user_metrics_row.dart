import 'package:flutter/material.dart';

class UserMetricsRow extends StatelessWidget {
  final double weight;
  final double height;
  final int age;
  final String gender;

  const UserMetricsRow({
    Key? key,
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMetricItem('Weight', '$weight kg'),
        _buildMetricItem('Height', '$height cm'),
        _buildMetricItem('Age', '$age'),
        _buildMetricItem('Gender', gender),
      ],
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
