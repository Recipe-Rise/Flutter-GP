import 'package:fitfork_gp/features/Home/presentation/widgets/calorie_summary_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/macronutrient_Progress.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/meal_entery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CaloriesTrackingScreen extends StatelessWidget {
  const CaloriesTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Calories',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalorieSummaryCard(
                consumedCalories: 760,
                totalCalories: 2000,
                remainingCalories: 1240,
                burnedCalories: 320,
              ),

              SizedBox(height: 24),

              // Macronutrients section
              Text(
                'Macronutrients',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A3A3A)),
              ),

              SizedBox(height: 16),

              MacronutrientProgress(
                color: Colors.blue,
                label: 'Proteins',
                current: 27,
                goal: 75,
                percentage: 36,
              ),

              SizedBox(height: 12),

              MacronutrientProgress(
                color: Colors.orange,
                label: 'Carbs',
                current: 96,
                goal: 250,
                percentage: 38,
              ),

              SizedBox(height: 12),

              MacronutrientProgress(
                color: Colors.pink,
                label: 'Fats',
                current: 22,
                goal: 67,
                percentage: 33,
              ),

              SizedBox(height: 24),

              Text(
                'Today\'s Meals',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A3A3A)),
              ),

              SizedBox(height: 16),

              MealEntry(
                mealType: 'Breakfast',
                mealItems: 'Toast, eggs, coffee',
                calories: 320,
                icon: Icons.wb_sunny_outlined,
                iconBackgroundColor: Color(0xFFFFF3E0),
                iconColor: Colors.orange,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF26A69A),
        child: const Icon(Icons.add, size: 32),
      ),
    );
  }
}
