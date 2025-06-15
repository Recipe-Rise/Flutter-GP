import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:fitfork_gp/features/Recipes/data/models/recipe_rec_model.dart';
import 'package:fitfork_gp/features/Recipes/data/repo/recipe_repository.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/states.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/customize_recipe_from_history.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/recipe_detail_screen.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/recipe_card.dart';
import 'package:fitfork_gp/features/Recipes/presentation/widgets/recommendation_card.dart';
import 'package:fitfork_gp/features/Recipes/presentation/views/customize_recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryRecipesScreen extends StatefulWidget {
  final String category;
  // final List<RecipeRecommendation>? customizedRecipes;

  const CategoryRecipesScreen({
    super.key,
    required this.category,
    // this.customizedRecipes,
  });

  @override
  State<CategoryRecipesScreen> createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  bool _usePreferences = false;

  // New method to navigate to the customization screen
  void _navigateToCustomization() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomizeRecipeScreen(
          category: widget.category,
        ),
      ),
    );
  }

  void _navigateToCustomizationFromHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomizeRecipeFromHistory(
          category: widget.category,
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

  List<RecipeRecommendation> recipes = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // Use customized recipes if provided
  //   if (widget.customizedRecipes != null) {
  //     recipes = widget.customizedRecipes!;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeRecommendationCubit,RecipesRecommendationStates>(
      listener: (context , state){
        if(state is RecipeRecommendationFromHistorySuccessState){
          setState(() {
            recipes = state.recipes;
          });
        }
        else if (state is RecipesRecommendationSuccessState) {
          setState(() {
            recipes = state.recipes;
          });
        } else if (state is RecipesRecommendationErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${state.error}')),
        );
        }
        else if (state is RecipeRecommendationFromHistoryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }

      },
      builder: (context , state){
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
                    title: "Recommend Recipes Based On My Preferences",
                    icon: FontAwesomeIcons.dice,
                    iconBackgroundColor: Colors.blue.shade400,
                    isSelected: !_usePreferences,
                    onTap: () {
                      setState(() {

                        _usePreferences = false;
                        _navigateToCustomizationFromHistory();

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
                        _navigateToCustomization();

                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Recipes list
                  Expanded(
                    child: state is RecipesRecommendationLoadingState || state is RecipeRecommendationFromHistoryLoadingState
                        ? const Center(child: CircularProgressIndicator())
                        : recipes.isEmpty
                        ? const Center(
                      child: Text(
                        "No recipes found",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                        : ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = recipes[index];
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
      },
    );
  }
}
