import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fitfork_gp/core/utils/app_navigator.dart';

class ProfileBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const ProfileBottomNavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: const Color(0xFF1A75FF),
      unselectedItemColor: Colors.grey,
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index != selectedIndex) {
          // Use AppNavigator to handle navigation
          final registerCubit = context.read<RegisterCubit>();
          final args = {
            'firstName': registerCubit.registerData.firstName,
            'bmi': registerCubit.calculateBMI(),
            'bmr': registerCubit.calculateBMR(),
          };
          AppNavigator.navigateToTabScreen(context, index, arguments: args);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.dumbbell),
          label: 'Workouts',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.utensils),
          label: 'Recipes',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: 'Profile',
        ),
      ],
    );
  }
}
