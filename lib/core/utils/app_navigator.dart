// lib/core/utils/app_navigator.dart

import 'package:fitfork_gp/features/Home/presentation/views/home_screen.dart';
import 'package:fitfork_gp/features/Login/presentation/cubit/login_cubit.dart';
import 'package:fitfork_gp/features/Profile/presentation/views/profile_screen2.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/recipes_screen.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/views/workout_screen.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/features/chat/presentation/views/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../features/WorkOuts/presentation/views/all_ex_view.dart';

// Import other screens as needed

class AppNavigator {
  // Navigate to screen based on bottom navigation index
  static void navigateToTabScreen(BuildContext context, int index,
      {Object? arguments}) {
    // Get current route to avoid pushing the same route
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    String routeName;
    Widget screen;

    switch (index) {
      case 0:
        routeName = '/home';
        screen = HomeScreen(
          firstName: AppCubit.get(context).getUserData!.name!,
          bmi: double.tryParse(AppCubit.get(context).getUserData?.bmi ?? '') ?? 0.0,
          bmr: double.tryParse(AppCubit.get(context).getUserData?.bmr ?? '') ?? 0.0,
        );
        break;
      case 1:
        routeName = '/workouts';
        screen = const WorkoutsScreen();
        break;

      case 2:
        routeName = '/chat';
        screen = const ChatScreen();
        break;

      case 3:
        routeName = '/recipes';
        screen = const RecipesScreen();
        break;

      case 4:
        routeName = '/profile';
        screen = BlocProvider.value(
        value: appCubit,
    child: const ProfileScreen2(),);
        break;

      default:
        return;
    }

    // Don't navigate if already on the route
    if (currentRoute == routeName) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
        settings: RouteSettings(name: routeName),
      ),
    );
  }
}
