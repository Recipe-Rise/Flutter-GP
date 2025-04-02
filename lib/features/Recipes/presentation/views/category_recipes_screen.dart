import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:fitfork_gp/features/Recipes/data/repo/recipe_repository.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/recipe_detail_screen.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/recipe_card.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/recommendation_card.dart';
// Add import for the new screen
import 'package:fitfork_gp/features/Recipes/presentation/views/customize_recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryRecipesScreen extends StatefulWidget {
  final String category;
  final String firstName;
  final double bmi;
  final double bmr;

  const CategoryRecipesScreen({
    super.key,
    required this.category,
    required this.firstName,
    required this.bmi,
    required this.bmr,
  });

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  final RecipeRepository _repository = RecipeRepository();
  List<Recipe> _recipes = [];
  bool _isLoading = true;
  bool _usePreferences = false;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _recipes = _repository.getRecipes(widget.category);
      _isLoading = false;
    });
  }

  // New method to handle filtered recipes from customization screen
  void _handleFilteredRecipes(List<Recipe> filteredRecipes) {
    setState(() {
      _recipes = filteredRecipes;
    });
  }

  // New method to navigate to the customization screen
  void _navigateToCustomization() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomizeRecipeScreen(
          category: widget.category,
          onRecipesFiltered: _handleFilteredRecipes,
        ),
      ),
    );
  }

  String getCategoryTitle() {
    switch (widget.category) {
      case 'breakfast':
        return 'Breakfast Recipes';
      case 'lunch':
        return 'Lunch Recipes';
      case 'dinner':
        return 'Dinner Recipes';
      default:
        return 'Recipes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getCategoryTitle(),
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Recommendation options
              RecommendationCard(
                title: "Recommend Random Recipes",
                icon: FontAwesomeIcons.dice,
                iconBackgroundColor: Colors.blue.shade400,
                isSelected: !_usePreferences,
                onTap: () {
                  setState(() {
                    _usePreferences = false;
                    _loadRecipes();
                  });
                },
              ),
              RecommendationCard(
                title: "Recommend With My Choices",
                icon: FontAwesomeIcons.check,
                iconBackgroundColor: Colors.green.shade400,
                isSelected: _usePreferences,
                onTap: () {
                  setState(() {
                    _usePreferences = true;
                    // Navigate to customization screen instead of directly loading recipes
                    _navigateToCustomization();
                  });
                },
              ),
              const SizedBox(height: 16),

              // Recipes list
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _recipes.isEmpty
                        ? const Center(
                            child: Text(
                              "No recipes found",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _recipes.length,
                            itemBuilder: (context, index) {
                              final recipe = _recipes[index];
                              return RecipeCard(
                                recipe: recipe,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipeDetailScreen(
                                        recipe: recipe,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
