import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/cubits/onboarding_cubit.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/barrier_option_tile.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/widgets/progress_indicator_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarriersScreen extends StatelessWidget {
  const BarriersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Barriers',
              style: TextStyle(
                fontSize: screenHeight * 0.025,
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
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressIndicatorBar(currentStep: 2, totalSteps: 5),
                SizedBox(height: screenHeight * 0.03),
                Text(
                  "In the past, what have been your barriers to maintaining weight?",
                  style: TextStyle(
                    fontSize: screenHeight * 0.028,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  "Select all that apply.",
                  style: TextStyle(
                    fontSize: screenHeight * 0.018,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildBarrierTile(context, 'Lack of time', state),
                        _buildSpacer(screenHeight),
                        _buildBarrierTile(
                            context, 'The regimen was hard to follow', state),
                        _buildSpacer(screenHeight),
                        _buildBarrierTile(
                            context, 'Healthy diets lack variety', state),
                        _buildSpacer(screenHeight),
                        _buildBarrierTile(
                            context, 'Stress around food choices', state),
                        _buildSpacer(screenHeight),
                        _buildBarrierTile(
                            context, 'Holidays/Vacation/Social Events', state),
                        _buildSpacer(screenHeight),
                        _buildBarrierTile(context, 'Food cravings', state),
                        _buildSpacer(screenHeight),
                        _buildBarrierTile(context, 'Lack of progress', state),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: CustomGradientButton(
                    text: 'Next',
                    onPressed: state.selectedBarriers.isNotEmpty
                        ? () => context
                            .read<OnboardingCubit>()
                            .goToNextScreen(context)
                        : null,
                    gradient: state.selectedBarriers.isNotEmpty
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
                    height: screenHeight * 0.065,
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

  Widget _buildBarrierTile(
      BuildContext context, String title, OnboardingState state) {
    return BarrierOptionTile(
      title: title,
      isSelected: state.selectedBarriers.contains(title),
      onTap: () => context.read<OnboardingCubit>().toggleBarrier(title),
    );
  }

  Widget _buildSpacer(double screenHeight) {
    return SizedBox(height: screenHeight * 0.015);
  }
}
