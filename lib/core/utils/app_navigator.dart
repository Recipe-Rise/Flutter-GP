// lib/core/utils/app_navigator.dart

import 'package:fitfork_gp/features/Home/presentation/views/home_screen.dart';
import 'package:fitfork_gp/features/Profile/presentation/views/profile_screen.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/recipes_screen.dart';
import 'package:fitfork_gp/features/Workout/presentation/views/workout_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static void navigateToTabScreen(BuildContext context, int index,
      {Object? arguments}) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    String routeName;
    Widget screen;

    switch (index) {
      case 0:
        routeName = '/home';
        screen = HomeScreen(
          firstName: arguments != null ? (arguments as Map)['firstName'] : '',
          bmi: arguments != null ? (arguments as Map)['bmi'] : 0.0,
          bmr: arguments != null ? (arguments as Map)['bmr'] : 0.0,
        );
        break;
      case 1:
        routeName = '/workouts';
        // Replace with your workouts screen
        screen = const WorkoutsScreen();
        break;
      case 2:
        routeName = '/recipes';
        // Replace with your recipes screen
        screen = const RecipesScreen();
        break;
      case 3:
        routeName = '/profile';
        screen = const ProfileScreen();
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
