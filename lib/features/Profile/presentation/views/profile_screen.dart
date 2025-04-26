import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_header.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_menu_section.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_stats_section.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final registerData = context.read<RegisterCubit>().registerData;
        final bmi = context.read<RegisterCubit>().calculateBMI();
        final bmr = context.read<RegisterCubit>().calculateBMR();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'My Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  // Add settings functionality
                },
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  Color(0xFFe6f2ff).withOpacity(0.3),
                ],
                stops: [0.0, 0.7, 1.0],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ProfileHeader(userData: registerData),
                    const SizedBox(height: 32),
                    ProfileStatsSection(
                      userData: registerData,
                      bmi: bmi,
                      bmr: bmr,
                    ),
                    const SizedBox(height: 40),
                    const ProfileMenuSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 8,
            selectedItemColor: Color(0xFF4da0ff),
            unselectedItemColor: Colors.grey,
            currentIndex: 4, // Profile tab is index 4
            onTap: (index) {
              if (index != 4) {
                AppNavigator.navigateToTabScreen(context, index);
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
                icon: Icon(FontAwesomeIcons.message),
                label: 'Chatbot',
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
          ),
        );
      },
    );
  }
}
