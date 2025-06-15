import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:fitfork_gp/features/Recipes/data/models/recipe_rec_model.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../Profile/presentation/views/edit_profile_screen.dart';
import '../widgets/nutrition_section_widget.dart';
import '../widgets/recipe_header_widget.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeRecommendation recipe;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}


class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    final double buttonHeight = screenSize.height * 0.07;

    return BlocConsumer<RecipeRecommendationCubit,RecipesRecommendationStates>(
      listener: (context, state) {
        if (state is AddRecipeToHistorySuccessState) {
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else if (state is AddRecipeToHistoryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }

        if (state is RecipesRecommendationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context,state){
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe image placeholder
                  RecipeHeaderWidget(
                    recipe: widget.recipe,
                    onChoose: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    onBackPressed: () => Navigator.pop(context),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recipe info row
                        Row(
                          children: [
                            _buildInfoChip(
                              Icons.local_fire_department,
                              Colors.orange.shade700,
                              "${widget.recipe.calories} kcal",
                            ),
                            const SizedBox(width: 12),
                            _buildInfoChip(
                              Icons.access_time,
                              Colors.blue.shade700,
                              "${widget.recipe.minutes} min",
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Ingredients section
                        Text(
                          " 🥘 Ingredients",
                          style: Styles.textStyle20
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        ...widget.recipe.ingredients?.split(',').map((ingredient) => _buildListItem(ingredient.trim())) ?? [],

                        const SizedBox(height: 24),

                        // Instructions section
                        Text(
                          " 📝  Instructions",
                          style: Styles.textStyle20
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          widget.recipe.steps!.length ,
                              (index) => _buildNumberedListItem(
                            index + 1,
                            widget.recipe.steps![index],
                          ),
                        ),

                        const SizedBox(height: 32),
                        Text(
                          ' 📊  Nutrition Info',
                          style: Styles.textStyle20
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        NutritionSectionWidget(
                          recipe: widget.recipe,
                        ),
                        const SizedBox(height: 32),
                        // Center(
                        //   child: CustomGradientButton(
                        //     text: 'Add This Recipe To My History',
                        //     onPressed: (){
                        //
                        //       showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return AlertDialog(
                        //             title: const Text('Add Recipe to History'),
                        //             content: const Text('Are you sure you want to add this recipe to your history?'),
                        //             actions: [
                        //               TextButton(
                        //                 onPressed: () {
                        //                   Navigator.of(context).pop();
                        //                 },
                        //                 child: const Text('Cancel'),
                        //               ),
                        //               TextButton(
                        //                 onPressed: () {
                        //                   Navigator.of(context).pop();
                        //                   RecipeRecommendationCubit.get(context).addRecipeToUserHistory(
                        //                     calories: widget.recipe.calories ?? 0,
                        //                     carbohydrates: widget.recipe.carbohydratesPDV ?? 0,
                        //                     recipeDescription: widget.recipe.description ?? '',
                        //                     ingredients: widget.recipe.ingredients ?? '',
                        //                     minutes: widget.recipe.minutes ?? 0,
                        //                     numOfSteps: widget.recipe.nSteps ?? 0,
                        //                     numOfIngredients: widget.recipe.nIngredients ?? 0,
                        //                     name: widget.recipe.name ?? '',
                        //                     protein: widget.recipe.proteinPDV ?? 0,
                        //                     saturatedFat: widget.recipe.saturatedFatPDV ?? 0,
                        //                     similarity: widget.recipe.similarity ?? 0,
                        //                     sodium: widget.recipe.sodiumPDV ?? 0,
                        //                     steps: widget.recipe.steps!,
                        //                     sugar: widget.recipe.sugarPDV ?? 0,
                        //                     fat: widget.recipe.totalFatPDV ?? 0,
                        //                   );
                        //                 },
                        //                 child: const Text('Confirm'),
                        //               ),
                        //             ],
                        //           );
                        //         },
                        //       );
                        //
                        //     },
                        //     icon: FontAwesomeIcons.plus,
                        //     gradient: LinearGradient(
                        //       colors: [
                        //         Color.fromARGB(255, 78, 141, 224),
                        //         Color.fromARGB(255, 31, 22, 199)
                        //       ],
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //     ),
                        //     width: screenSize.width * 0.8,
                        //     height: buttonHeight,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ),
          floatingActionButton: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // const Color.fromARGB(255, 78, 141, 224),
                  // const Color.fromARGB(255, 31, 22, 199),

                  Color(0xFF667eea), Color(0xFF764ba2)

                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 31, 22, 199).withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: () {
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
                              calories: widget.recipe.calories ?? 0,
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
              },
              child: const Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
              backgroundColor: Colors.transparent, // Transparent to show the gradient
              elevation: 0, // Remove default shadow
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            text,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Styles.textStyle16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedListItem(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Styles.textStyle16,
            ),
          ),
        ],
      ),
    );
  }
}
