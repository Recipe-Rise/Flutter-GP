import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/cubits/onboarding_cubit.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/progress_indicator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoalConfirmationScreen extends StatelessWidget {
  const GoalConfirmationScreen({Key? key}) : super(key: key);

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
          onPressed: () =>
              context.read<OnboardingCubit>().goToPreviousScreen(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProgressIndicatorBar(currentStep: 1, totalSteps: 5),
            SizedBox(height: screenHeight * 0.07),
            Text(
              "Great! You've just taken a big step on your journey.",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Did you know that tracking your food is a scientifically proven method to being successful? It's called \"self-monitoring\" and the more consistent you are, the more likely you are to hit your goals.",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Text(
                  "Now, let's talk about your goal to ${state.getMainGoalDescription()}.",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                );
              },
            ),
            const Spacer(),
            Center(
              child: CustomGradientButton(
                text: 'Next',
                onPressed: () =>
                    context.read<OnboardingCubit>().goToNextScreen(context),
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
  }
}
