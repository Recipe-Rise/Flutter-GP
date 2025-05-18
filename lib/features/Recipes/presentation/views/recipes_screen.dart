import 'package:fitfork_gp/features/Recipes/presentation/views/category_recipes_screen.dart';
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

class _RecipesScreenState extends State<RecipesScreen> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Recipes",
            style: Styles.textStyle26,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.bell,
              size: 18,
            ),
            onPressed: () {},
          ),
        ],
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
                      CategoryCard(
                        title: "Breakfast",
                        subtitle: "Start your day with energizing meals",
                        backgroundColor: const Color(0xFF5BC0DE),
                        icon: Icons.free_breakfast,
                        onTap: () => _navigateToCategory('breakfast'),
                      ),
                      const SizedBox(height: 16),
                      CategoryCard(
                        title: "Lunch",
                        subtitle: "Delicious midday meal options",
                        backgroundColor: const Color(0xFF5B99DE),
                        icon: Icons.lunch_dining,
                        onTap: () => _navigateToCategory('lunch'),
                      ),
                      const SizedBox(height: 16),
                      CategoryCard(
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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  void _navigateToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryRecipesScreen(
          category: category,
          firstName: widget.firstName,
          bmi: widget.bmi,
          bmr: widget.bmr,
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
}
