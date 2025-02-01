import 'package:flutter/material.dart';

class GoalSelector extends StatelessWidget {
  final String selectedGoal;
  final ValueChanged<String> onGoalSelected;

  const GoalSelector({
    super.key,
    required this.selectedGoal,
    required this.onGoalSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What is your goal?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        _buildGoalButton('Improve Shape'),
        _buildGoalButton('Lose Weight'),
        _buildGoalButton('Gain Muscle'),
      ],
    );
  }

  Widget _buildGoalButton(String goal) {
    return ListTile(
      title: Text(goal),
      leading: Radio(
        value: goal,
        groupValue: selectedGoal,
        onChanged: (value) => onGoalSelected(value as String),
      ),
    );
  }
}
