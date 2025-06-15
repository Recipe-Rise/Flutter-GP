import 'dart:math';

import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/category_recipes_screen.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/recipe_history_screen.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/animated_category_card.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/category_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipesScreen extends StatefulWidget {
  final String firstName;
  final double bmi;
  final double bmr;

  const RecipesScreen({
    super.key,
    this.firstName = '',
    this.bmi = 0.0,
    this.bmr = 0.0,
  });

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen>
with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Recipes",
            style: Styles.textStyle26,
          ),
        ),

      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedCategoryCard(
                        title: "Breakfast",
                        subtitle: "Start your day with energizing meals",
                        backgroundColor: const Color(0xFF5BC0DE),
                        icon: Icons.free_breakfast,
                        onTap: () => _navigateToCategory('breakfast'),
                      ),
                      const SizedBox(height: 16),
                      AnimatedCategoryCard(
                        title: "Lunch",
                        subtitle: "Delicious midday meal options",
                        backgroundColor: const Color(0xFF5B99DE),
                        icon: Icons.lunch_dining,
                        onTap: () => _navigateToCategory('lunch'),
                      ),
                      const SizedBox(height: 16),
                      AnimatedCategoryCard(
                        title: "Dinner",
                        subtitle: "Perfect evening meal collection",
                        backgroundColor: const Color(0xFF5B6EDE),
                        icon: Icons.dinner_dining,
                        onTap: () => _navigateToCategory('dinner'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 2 * pi,
            child: FloatingActionButton(
              onPressed: () {
                if (_animationController.isCompleted) {
                  _animationController.reverse();
                } else {
                  _animationController.forward();
                }
                _showHistoryDialog(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
              backgroundColor: null, // Gradient applied below
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5BC0DE), Color(0xFF5B99DE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.history, color: Colors.white),
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  void _navigateToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryRecipesScreen(
          category: category,
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: const Color(0xFF1A75FF),
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (index != _selectedIndex) {
          final args = {
            'firstName': widget.firstName,
            'bmi': widget.bmi,
            'bmr': widget.bmr,
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
    );
  }

  void _showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('View Recipe History'),
          content: const Text('Do you want to view your recipe history?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                RecipeRecommendationCubit.get(context).getUserRecipeHistory();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecipeHistoryPage(),
                  ),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

}
