import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onGenderSelected;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Gender',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            _buildGenderButton('Male', selectedGender == 'Male'),
            const SizedBox(width: 16),
            _buildGenderButton('Female', selectedGender == 'Female'),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton(String gender, bool isSelected) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onGenderSelected(gender),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
        ),
        child: Text(gender),
      ),
    );
  }
}
