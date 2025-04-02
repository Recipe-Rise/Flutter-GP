import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/cubits/onboarding_cubit.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/activity_level_option.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/progress_indicator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityLevelScreen extends StatelessWidget {
  const ActivityLevelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Activity Level',
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
                  context.read<OnboardingCubit>().goToPreviousScreen(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressIndicatorBar(currentStep: 5, totalSteps: 5),
                const SizedBox(height: 24),
                const Text(
                  "What is your baseline activity level?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Not including workouts - we count that separately.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Choose what describes you best:",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),

                // Activity level options
                ActivityLevelOption(
                  title: 'Not Very Active',
                  description:
                      'Spend most of the day sitting (e.g., bank teller, desk job).',
                  isSelected: state.activityLevel == 'Not Very Active',
                  onTap: () => context
                      .read<OnboardingCubit>()
                      .selectActivityLevel('Not Very Active'),
                ),
                ActivityLevelOption(
                  title: 'Lightly Active',
                  description:
                      'Spend a good part of the day on your feet (e.g., teacher, salesperson).',
                  isSelected: state.activityLevel == 'Lightly Active',
                  onTap: () => context
                      .read<OnboardingCubit>()
                      .selectActivityLevel('Lightly Active'),
                ),
                ActivityLevelOption(
                  title: 'Active',
                  description:
                      'Spend a good part of the day doing some physical activity (e.g., food server, postal carrier).',
                  isSelected: state.activityLevel == 'Active',
                  onTap: () => context
                      .read<OnboardingCubit>()
                      .selectActivityLevel('Active'),
                ),
                ActivityLevelOption(
                  title: 'Very Active',
                  description:
                      'Spend a good part of the day doing heavy physical activity (e.g., bike messenger, carpenter).',
                  isSelected: state.activityLevel == 'Very Active',
                  onTap: () => context
                      .read<OnboardingCubit>()
                      .selectActivityLevel('Very Active'),
                ),

                const Spacer(),

                // Replaced NavButton with CustomGradientButton
                Center(
                  child: CustomGradientButton(
                    text: 'Next',
                    onPressed: state.activityLevel.isNotEmpty
                        ? () => context
                            .read<OnboardingCubit>()
                            .finishOnboarding(context)
                        : null,
                    gradient: state.activityLevel.isNotEmpty
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF6A11CB),
                              Color(0xFF2575FC),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          )
                        : LinearGradient(
                            colors: [
                              const Color(0xFF6A11CB).withOpacity(0.5),
                              const Color(0xFF2575FC).withOpacity(0.5),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 56,
                    borderRadius: 28,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
