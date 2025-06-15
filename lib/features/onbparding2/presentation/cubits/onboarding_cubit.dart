import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/activity_level_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/barriers_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/goal_confirmation_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/goal_selection_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/help_screen.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/views/understanding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingState {
  final List<String> selectedGoals;
  final List<String> selectedBarriers;
  final String activityLevel;
  final int currentScreenIndex;

  OnboardingState({
    this.selectedGoals = const [],
    this.selectedBarriers = const [],
    this.activityLevel = '',
    this.currentScreenIndex = 0,
  });

  OnboardingState copyWith({
    List<String>? selectedGoals,
    List<String>? selectedBarriers,
    String? activityLevel,
    int? currentScreenIndex,
  }) {
    return OnboardingState(
      selectedGoals: selectedGoals ?? this.selectedGoals,
      selectedBarriers: selectedBarriers ?? this.selectedBarriers,
      activityLevel: activityLevel ?? this.activityLevel,
      currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
    );
  }

  bool get isGoalSelectionValid {
    bool hasWeightGoal = selectedGoals.contains('Lose Weight') ||
        selectedGoals.contains('Loss weight and gain muscles') ||
        selectedGoals.contains('Gain Weight') || selectedGoals.contains('Gain Muscle')
    || selectedGoals.contains('fitness');
    return selectedGoals.isNotEmpty &&
        selectedGoals.length <= 3 &&
        hasWeightGoal;
  }

  String getMainGoalDescription() {
    if (selectedGoals.contains('Maintain Weight')) {
      return 'maintain weight';
    } else if (selectedGoals.contains('Lose Weight')) {
      return 'lose weight';
    } else if (selectedGoals.contains('Gain Weight')) {
      return 'gain weight';
    } else if (selectedGoals.contains('Gain Muscle')) {
      return 'gain muscle';
    } else {
      return 'reach your goals';
    }
  }

  String getNextStepDescription() {
    if (selectedGoals.contains('Gain Muscle')) {
      return 'gain muscle';
    } else if (selectedGoals.contains('Lose Weight')) {
      return 'lose weight';
    } else if (selectedGoals.contains('Gain Weight')) {
      return 'gain weight';
    } else {
      return 'maintain weight';
    }
  }
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState());

  void toggleGoal(String goal) {
    if (isClosed) return;

    final currentGoals = List<String>.from(state.selectedGoals);
    if (currentGoals.contains(goal)) {
      currentGoals.remove(goal);
    } else if (currentGoals.length < 3) {
      currentGoals.add(goal);
    }
    emit(state.copyWith(selectedGoals: currentGoals));
  }

  void toggleBarrier(String barrier) {
    if (isClosed) return;

    final currentBarriers = List<String>.from(state.selectedBarriers);
    if (currentBarriers.contains(barrier)) {
      currentBarriers.remove(barrier);
    } else {
      currentBarriers.add(barrier);
    }
    emit(state.copyWith(selectedBarriers: currentBarriers));
  }

  void selectActivityLevel(String level) {
    if (isClosed) return;
    emit(state.copyWith(activityLevel: level));
  }

  Widget getScreenForIndex(int index) {
    final screens = [
      const GoalSelectionScreen(),
      const GoalConfirmationScreen(),
      const BarriersScreen(),
      const UnderstandingScreen(),
      const HelpScreen(),
      const ActivityLevelScreen(),
    ];
    return index < screens.length ? screens[index] : screens.last;
  }

  void goToNextScreen(BuildContext context) {
    if (isClosed || !context.mounted) return;

    final nextIndex = state.currentScreenIndex + 1;
    emit(state.copyWith(currentScreenIndex: nextIndex));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isClosed && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => getScreenForIndex(nextIndex)),
        );
      }
    });
  }

  void goToPreviousScreen(BuildContext context) {
    if (isClosed || !context.mounted) return;

    final prevIndex = state.currentScreenIndex - 1;
    if (prevIndex >= 0) {
      emit(state.copyWith(currentScreenIndex: prevIndex));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!isClosed && context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => getScreenForIndex(prevIndex)),
          );
        }
      });
    }
  }

  void finishOnboarding(BuildContext context) {
    if (isClosed || !context.mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isClosed && context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RegisterScreen1()),
        );
      }
    });
  }
}
