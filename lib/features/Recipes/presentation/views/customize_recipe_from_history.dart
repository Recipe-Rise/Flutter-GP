import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/styles.dart';
import '../../data/models/recipe_rec_model.dart';
import '../../data/repo/recipe_repository.dart';
import '../widgets/choice_ships_grid.dart';
import '../widgets/health_options_card.dart';
import '../widgets/range_slider_with_labels.dart';
import '../widgets/recipes_count_card.dart';
import '../widgets/slider_with_labels.dart';
import 'category_recipes_screen.dart';

class CustomizeRecipeFromHistory extends StatefulWidget {
  final String category;

  const CustomizeRecipeFromHistory({
    super.key,
    required this.category,
  });

  @override
  State<CustomizeRecipeFromHistory> createState() => _CustomizeRecipeFromHistoryState();
}

class _CustomizeRecipeFromHistoryState extends State<CustomizeRecipeFromHistory> {
  final RecipeRepository _repository = RecipeRepository();
  final List<String> _selectedIngredients = [];
  double _preparationTime = 30;
  RangeValues _caloriesRange = const RangeValues(200, 800);
  int _recipesCount = 1;
  bool _isDiabetesFriendly = false;
  int minCalories = 200;
  int maxCalories = 800;


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


  List<RecipeRecommendation> recipes = [];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double buttonHeight = screenSize.height * 0.07;

    return BlocConsumer<RecipeRecommendationCubit,RecipesRecommendationStates>(
        listener: (context, state) {
          if (state is RecipesRecommendationSuccessState) {
            recipes = state.recipes;
          }
          else if (state is RecipesRecommendationErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
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
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade400, Colors.blue.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.shade600.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Entering values is optional. The data shown are default values and can be customized as needed.',
                              style: Styles.textStyle16.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

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
                      min: 200,
                      max: 800,
                      values: _caloriesRange,
                      startLabel: '${_caloriesRange.start.toInt()} cal',
                      endLabel: '${_caloriesRange.end.toInt()} cal',
                      onChanged: (values) {

                        setState(() {
                          final snappedStart = (values.start / 50).round() * 50;
                          final snappedEnd = (values.end / 50).round() * 50;
                          _caloriesRange = RangeValues(snappedStart.toDouble(), snappedEnd.toDouble());
                          minCalories = values.start.toInt();
                          maxCalories = values.end.toInt();

                        });
                      },
                      startIcon: FontAwesomeIcons.leaf,
                      endIcon: FontAwesomeIcons.dumbbell,
                    ),
                    const SizedBox(height: 32),

                    SizedBox(height: 10,)
                  ],

                ),
              ),
            ),
            floatingActionButton: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade600.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {

                  RecipeRecommendationCubit.get(context).getRecommendedRecipesFromHistory(
                    numOfRecipes: _recipesCount,
                    minCalories: minCalories,
                    maxCalories: maxCalories,
                    diabeticFriendly: _isDiabetesFriendly,
                    maxPrepTime: _preparationTime.toInt(),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryRecipesScreen(
                        category: widget.category,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.white,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          );
        }
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

