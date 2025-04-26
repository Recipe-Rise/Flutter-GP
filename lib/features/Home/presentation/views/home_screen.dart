import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/activity_status_header.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/bmi_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/calories_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/sleep_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/water_intake_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String firstName;
  final double bmi;
  final double bmr;

  const HomeScreen({
    super.key,
    required this.firstName,
    required this.bmi,
    required this.bmr,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final waterIntakeUpdates = [
      {"time": "6am - 8am", "amount": "600"},
      {"time": "9am - 11am", "amount": "500"},
      {"time": "11am - 2pm", "amount": "1000"},
      {"time": "2pm - 4pm", "amount": "700"},
      {"time": "4pm - now", "amount": "900"},
    ];

    int totalWaterIntake = 0;
    for (var update in waterIntakeUpdates) {
      totalWaterIntake += int.parse(update["amount"]!);
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome Back,",
                    style: Styles.textStyle16.copyWith(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  const Icon(
                    FontAwesomeIcons.bell,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.firstName,
                style: Styles.textStyle26,
              ),
              const SizedBox(height: 16),
              BmiCard(bmi: widget.bmi),
              const SizedBox(height: 24),
              const ActivityStatusHeader(),
              const SizedBox(height: 16),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: WaterIntakeCard(
                        waterIntakeInML: totalWaterIntake,
                        timeUpdates: waterIntakeUpdates,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SleepCard(hours: "8", minutes: "20"),
                          const SizedBox(height: 16),
                          CaloriesCard(
                            bmr: widget.bmr,
                            consumedCalories: widget.bmr - 230,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: const Color(0xFF1A75FF),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index != _selectedIndex) {
            // Use AppNavigator to handle navigation
            final args = {
              'firstName': widget.firstName,
              'bmi': widget.bmi,
              'bmr': widget.bmr,
            };
            AppNavigator.navigateToTabScreen(context, index, arguments: args);
          } else {
            setState(() {
              _selectedIndex = index;
            });
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
  }
}
