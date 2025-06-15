import 'package:fitfork_gp/features/onbparding2/presentation/views/activity_level_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/understanding_screen.dart';
import 'package:flutter/material.dart';

class GoalConfirmationScreen extends StatefulWidget {
  final String? selectedGoal;

  const GoalConfirmationScreen({Key? key, this.selectedGoal}) : super(key: key);

  @override
  State<GoalConfirmationScreen> createState() => _GoalConfirmationScreenState();
}

class _GoalConfirmationScreenState extends State<GoalConfirmationScreen> {

  String getMainGoalDescription() {
    switch (widget.selectedGoal) {
      case 'Lose Weight':
        return 'lose weight';
      case 'Loss weight and gain muscles':
        return 'lose weight and gain muscles';
      case 'Gain Weight':
        return 'gain weight';
      case 'Gain Muscle':
        return 'gain muscle';
      case 'Fitness':
        return 'improve your fitness';
      default:
        return 'achieve your fitness goal';
    }
  }

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.07),
            const Text(
              "Great! You've just taken a big step on your journey.",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Did you know that tracking your food is a scientifically proven method to being successful? It's called \"self-monitoring\" and the more consistent you are, the more likely you are to hit your goals.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Now, let's talk about your goal to ${getMainGoalDescription()}.",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Center(
              child: Container(
                width: screenWidth * 0.85,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ActivityLevelScreen(),
                      ),
                    );
                    print('Moving to understanding screen');
                  },
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