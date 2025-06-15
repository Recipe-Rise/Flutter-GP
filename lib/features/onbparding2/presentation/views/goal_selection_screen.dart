import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/goal_confirmation_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/understanding_screen.dart';
import 'package:flutter/material.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({Key? key}) : super(key: key);

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  String? selectedGoal;

  final List<String> goals = [
    'Lose Weight',
    'Loss weight and gain muscles',
    'Gain Weight',
    'Gain Muscle',
    'Fitness',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Goals',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.04),
            const Text(
              "Let's start with goals.",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Select your main fitness goal.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: goals.map((goal) {
                    return Column(
                      children: [
                        GoalOptionTile(
                          title: goal,
                          isSelected: selectedGoal == goal,
                          onTap: () {
                            setState(() {
                              selectedGoal = goal;
                            });
                          },
                        ),
                        SizedBox(height: screenHeight * 0.015),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Container(
                width: screenWidth * 0.85,
                height: 56,
                decoration: BoxDecoration(
                  gradient: selectedGoal != null
                      ? const LinearGradient(
                    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                      : LinearGradient(
                    colors: [
                      const Color(0xFF6A11CB).withOpacity(0.5),
                      const Color(0xFF2575FC).withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: selectedGoal != null
                      ? () {

                    RegisterCubit.get(context).updateFitnessGoal(selectedGoal!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoalConfirmationScreen(),
                      ),
                    );
                    // Navigate to next screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const NextScreen(),
                    //   ),
                    // );
                    print('Selected goal: $selectedGoal');
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}

// Simple Goal Option Tile Widget
class GoalOptionTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalOptionTile({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2575FC).withOpacity(0.1) : Colors.grey[100],
          border: Border.all(
            color: isSelected ? const Color(0xFF2575FC) : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF2575FC) : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF2575FC),
              ),
          ],
        ),
      ),
    );
  }
}