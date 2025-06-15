import 'package:fitfork_gp/features/Recipes/data/models/recipe_rec_model.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NutritionSectionWidget extends StatelessWidget {
  final RecipeRecommendation recipe;

  const NutritionSectionWidget({
    Key? key,
    required this.recipe,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeRecommendationCubit,RecipesRecommendationStates>(
      listener: (context,state){},

      builder: (context,state){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                NutritionCardWidget(
                  value: recipe.calories.toString(),
                  label: 'Calories',
                ),
                NutritionCardWidget(
                  value: recipe.proteinPDV.toString(),
                  label: 'Protein',
                ),
                NutritionCardWidget(
                  value: recipe.carbohydratesPDV.toString(),
                  label: 'Carbs',
                ),
                NutritionCardWidget(
                  value: recipe.totalFatPDV.toString(),
                  label: 'Fat',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class NutritionCardWidget extends StatelessWidget {
  final String value;
  final String label;

  const NutritionCardWidget({
    Key? key,
    required this.value,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}