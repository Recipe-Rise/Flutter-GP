import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:fitfork_gp/features/Recipes/data/models/recipe_rec_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants.dart';
import '../../../../shared/cubit/appCubit.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../cubit/recipe_cubit.dart';

class RecipeHeaderWidget extends StatefulWidget {
  final RecipeRecommendation recipe;
  final VoidCallback onChoose;
  final VoidCallback onBackPressed;

  const RecipeHeaderWidget({
    Key? key,
    required this.recipe,
    required this.onChoose,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  State<RecipeHeaderWidget> createState() => _RecipeHeaderWidgetState();
}

class _RecipeHeaderWidgetState extends State<RecipeHeaderWidget> {

  Future<void> _subtractCalories() async {
    final double bmr = double.tryParse(AppCubit.get(context).getUserData?.bmr ?? '0') ?? 0.0;
    double remainingCalories = await CacheHelper().getRemainingCalories(bmr);

    remainingCalories = (remainingCalories - (widget.recipe.calories ?? 0)).clamp(0.0, bmr);
    await CacheHelper().saveRemainingCalories(remainingCalories);

    Fluttertoast.showToast(
      msg: 'Calories subtracted! Remaining: $remainingCalories',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 78, 141, 224),
              Color.fromARGB(255, 31, 22, 199)
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onBackPressed,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Action'),
                          content: Text(
                            'This recipe contains ${widget.recipe.calories} calories. '
                                'Do you want to subtract it from your remaining daily calories?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {

                                final double bmr = double.tryParse(AppCubit.get(context).getUserData?.bmr ?? '0') ?? 0.0;
                                double remainingCalories = await CacheHelper().getRemainingCalories(bmr);

                                final double recipeCalories = widget.recipe.calories ?? 0.0;

                                if (recipeCalories > remainingCalories) {
                                  // Show an alert if the recipe's calories exceed the available calories
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Exceeds Available Calories'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.warning_amber_rounded,
                                              color: Colors.red,
                                              size: 48,
                                            ),
                                            const SizedBox(height: 16),

                                            Text(
                                              'This recipe contains $recipeCalories calories, which exceeds your available calories of $remainingCalories.',
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  // Proceed with subtraction
                                  await _subtractCalories();
                                  Navigator.of(context).pop();

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Add Recipe to History'),
                                        content: const Text('Are you sure you want to add this recipe to your history?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              RecipeRecommendationCubit.get(context).addRecipeToUserHistory(
                                                calories: recipeCalories,
                                                carbohydrates: widget.recipe.carbohydratesPDV ?? 0,
                                                recipeDescription: widget.recipe.description ?? '',
                                                ingredients: widget.recipe.ingredients ?? '',
                                                minutes: widget.recipe.minutes ?? 0,
                                                numOfSteps: widget.recipe.nSteps ?? 0,
                                                numOfIngredients: widget.recipe.nIngredients ?? 0,
                                                name: widget.recipe.name ?? '',
                                                protein: widget.recipe.proteinPDV ?? 0,
                                                saturatedFat: widget.recipe.saturatedFatPDV ?? 0,
                                                similarity: widget.recipe.similarity ?? 0,
                                                sodium: widget.recipe.sodiumPDV ?? 0,
                                                steps: widget.recipe.steps!,
                                                sugar: widget.recipe.sugarPDV ?? 0,
                                                fat: widget.recipe.totalFatPDV ?? 0,
                                              );
                                            },
                                            child: const Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.recipe.name!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _MetaItem(
                  // icon: Icons.access_time,
                  text: '⏱️  ' + widget.recipe.minutes.toString() + ' min',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  // final IconData icon;
  final String text;

  const _MetaItem({
    // required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(
        //   icon,
        //   color: Colors.white.withOpacity(0.9),
        //   size: 16,
        // ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}