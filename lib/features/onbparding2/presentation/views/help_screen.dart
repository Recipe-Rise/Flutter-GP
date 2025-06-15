import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/cubits/onboarding_cubit.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/activity_level_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/progress_indicator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
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
              onPressed: () =>
                  Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressIndicatorBar(currentStep: 4, totalSteps: 5),
                SizedBox(height: screenHeight * 0.07),
                const Text(
                  "Great, we can help you get the look you want.",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "We recommend you try some of our bodyweight and low-weight HIIT workout routines. We also recommend tracking your macronutrients to make sure you're getting enough protein.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Let's get more details so we can help you hit your goals.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Center(
                  child: CustomGradientButton(
                    text: 'Next',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityLevelScreen(),
                        ),
                      );
                    },
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    width: screenWidth * 0.85,
                    height: 56,
                    borderRadius: 28,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }
}
