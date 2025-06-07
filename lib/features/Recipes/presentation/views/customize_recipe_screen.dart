import 'package:fitfork_gp/features/Recipes/presentation/widgets/choice_ships_grid.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/range_slider_with_labels.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/slider_with_labels.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/recipes_count_card.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/health_options_card.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:fitfork_gp/features/Recipes/data/repo/recipe_repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomizeRecipeScreen extends StatefulWidget {
  final String category;
  final Function(List<Recipe>) onRecipesFiltered;

  const CustomizeRecipeScreen({
    Key? key,
    required this.category,
    required this.onRecipesFiltered,
  }) : super(key: key);

  @override
  State<CustomizeRecipeScreen> createState() => _CustomizeRecipeScreenState();
}

class _CustomizeRecipeScreenState extends State<CustomizeRecipeScreen> {
  final RecipeRepository _repository = RecipeRepository();
  final List<String> _selectedIngredients = [];
  double _preparationTime = 30;
  RangeValues _caloriesRange = const RangeValues(100, 800);
  int _recipesCount = 5;
  bool _isDiabetesFriendly = false;

  final List<String> _breakfastIngredients = [
    'Eggs',
    'Avocado',
    'Oats',
    'Berries',
    'Yogurt',
    'Bread',
    'Banana',
    'Spinach',
    'Cheese'
  ];

  final List<String> _lunchIngredients = [
    'Chicken',
    'Rice',
    'Pasta',
    'Vegetables',
    'Beef',
    'Tofu',
    'Quinoa',
    'Salad',
    'Fish'
  ];

  final List<String> _dinnerIngredients = [
    'Salmon',
    'Chicken',
    'Vegetables',
    'Potatoes',
    'Steak',
    'Tofu',
    'Rice',
    'Pasta',
    'Soup'
  ];

  List<String> get _ingredientsForCategory {
    switch (widget.category) {
      case 'breakfast':
        return _breakfastIngredients;
      case 'lunch':
        return _lunchIngredients;
      case 'dinner':
        return _dinnerIngredients;
      default:
        return _breakfastIngredients;
    }
  }

  String getCategoryTitle() {
    switch (widget.category) {
      case 'breakfast':
        return 'Customize Breakfast';
      case 'lunch':
        return 'Customize Lunch';
      case 'dinner':
        return 'Customize Dinner';
      default:
        return 'Customize Recipes';
    }
  }

  void _findRecipes() {
    final List<Recipe> filteredRecipes = _repository.getFilteredRecipes(
      category: widget.category,
      ingredients: _selectedIngredients,
      mealType: '',
      maxPrepTime: _preparationTime.toInt(),
      caloriesRange: [_caloriesRange.start.toInt(), _caloriesRange.end.toInt()],
    );
    widget.onRecipesFiltered(filteredRecipes);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double buttonHeight = screenSize.height * 0.07;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(),
                      color: Colors.blue.shade600,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Customize your ${widget.category} recipes',
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              RecipesCountCard(
                initialCount: _recipesCount,
                minCount: 1,
                maxCount: 10,
                onCountChanged: (count) {
                  setState(() => _recipesCount = count);
                },
              ),
              const SizedBox(height: 24),
              HealthOptionsCard(
                initialDiabetesFriendly: _isDiabetesFriendly,
                onDiabetesFriendlyChanged: (isDiabetesFriendly) {
                  setState(() => _isDiabetesFriendly = isDiabetesFriendly);
                },
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(
                icon: Icons.restaurant,
                title: 'Ingredients',
              ),
              const SizedBox(height: 12),
              ChoiceChipsGrid(
                options: _ingredientsForCategory,
                selectedOptions: _selectedIngredients,
                onSelectionChanged: (ingredients) {
                  setState(() => _selectedIngredients
                    ..clear()
                    ..addAll(ingredients));
                },
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(
                icon: FontAwesomeIcons.clock,
                title: 'Preparation Time',
              ),
              const SizedBox(height: 12),
              SliderWithLabels(
                min: 5,
                max: 120,
                value: _preparationTime,
                label: '${_preparationTime.toInt()} min',
                onChanged: (value) {
                  setState(() => _preparationTime = value);
                },
                icon: FontAwesomeIcons.clock,
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(
                icon: FontAwesomeIcons.fire,
                title: 'Calories Range',
              ),
              const SizedBox(height: 12),
              RangeSliderWithLabels(
                min: 100,
                max: 1000,
                values: _caloriesRange,
                startLabel: '${_caloriesRange.start.toInt()} cal',
                endLabel: '${_caloriesRange.end.toInt()} cal',
                onChanged: (values) {
                  setState(() => _caloriesRange = values);
                },
                startIcon: FontAwesomeIcons.leaf,
                endIcon: FontAwesomeIcons.dumbbell,
              ),
              const SizedBox(height: 32),
              Center(
                child: CustomGradientButton(
                  text: 'Find Perfect Recipes',
                  onPressed: _findRecipes,
                  icon: FontAwesomeIcons.magnifyingGlass,
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade400, Colors.blue.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  width: screenSize.width * 0.8,
                  height: buttonHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (widget.category) {
      case 'breakfast':
        return FontAwesomeIcons.mugHot;
      case 'lunch':
        return FontAwesomeIcons.bowlFood;
      case 'dinner':
        return FontAwesomeIcons.utensils;
      default:
        return FontAwesomeIcons.utensils;
    }
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue.shade600),
        const SizedBox(width: 8),
        Text(
          title,
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
