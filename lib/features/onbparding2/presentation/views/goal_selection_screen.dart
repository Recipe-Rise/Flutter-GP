import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/cubits/onboarding_cubit.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/goal_option_tile.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/progress_indicator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalSelectionScreen extends StatelessWidget {
  const GoalSelectionScreen({Key? key}) : super(key: key);

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
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressIndicatorBar(currentStep: 0, totalSteps: 5),
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
                  "Select up to 3 that are important to you, including one weight goal.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GoalOptionTile(
                          title: 'Lose Weight',
                          isSelected:
                              state.selectedGoals.contains('Lose Weight'),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleGoal('Lose Weight'),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        GoalOptionTile(
                          title: 'Maintain Weight',
                          isSelected:
                              state.selectedGoals.contains('Maintain Weight'),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleGoal('Maintain Weight'),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        GoalOptionTile(
                          title: 'Gain Weight',
                          isSelected:
                              state.selectedGoals.contains('Gain Weight'),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleGoal('Gain Weight'),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        GoalOptionTile(
                          title: 'Gain Muscle',
                          isSelected:
                              state.selectedGoals.contains('Gain Muscle'),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleGoal('Gain Muscle'),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        GoalOptionTile(
                          title: 'Modify My Diet',
                          isSelected:
                              state.selectedGoals.contains('Modify My Diet'),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleGoal('Modify My Diet'),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        GoalOptionTile(
                          title: 'Plan Meals',
                          isSelected:
                              state.selectedGoals.contains('Plan Meals'),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleGoal('Plan Meals'),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        GoalOptionTile(
                          title: 'Manage Stress',
                          isSelected:
                              state.selectedGoals.contains('Manage Stress'),
                          onTap: () => context
                              .read<OnboardingCubit>()
                              .toggleGoal('Manage Stress'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: CustomGradientButton(
                    text: 'Next',
                    onPressed: state.isGoalSelectionValid
                        ? () => context
                            .read<OnboardingCubit>()
                            .goToNextScreen(context)
                        : null,
                    gradient: state.isGoalSelectionValid
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
