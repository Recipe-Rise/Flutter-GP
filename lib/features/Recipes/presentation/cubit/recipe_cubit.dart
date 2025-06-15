import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/features/Recipes/data/models/add_recipe_to_user_history.dart';
import 'package:fitfork_gp/features/Recipes/data/models/get_user_recipes_history.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/states.dart';
import 'package:fitfork_gp/shared/network/remote/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/recipe_rec_model.dart';

class RecipeRecommendationCubit extends Cubit<RecipesRecommendationStates> {

  RecipeRecommendationCubit() : super(RecipesRecommendationInitialState());

  static RecipeRecommendationCubit get(context) => BlocProvider.of(context);

  List<RecipeRecommendation> recipes = [];


  void getRecommendedRecipes ({
    required String recipeDescription,
    int numOfRecipes = 1,
    int minCalories = 200,
    int maxCalories = 800,
    bool diabeticFriendly = false,
    int maxPrepTime = 60,
})
  {
    emit(RecipesRecommendationLoadingState());

    DioHelper.postData3(
        url: 'ml_model/$user_id',
       data:{
          'recipe_description': recipeDescription,
         'num_recipes' : numOfRecipes,
         'min_calories': minCalories,
         'max_calories': maxCalories,
         'diabetic_friendly': diabeticFriendly,
         'max_prep_time': maxPrepTime,
       },
    ).then((value){

      final data = value?.data;

      if (data == null || data['recipes'] == null || data['recipes'].isEmpty) {
        emit(RecipesRecommendationEmptyState('No recipes found'));
        return;
      }

      recipes = (data['recipes'] as List)
          .map((recipe) => RecipeRecommendation.fromJson(recipe))
          .toList();

      print('Number of recommended recipes: ${recipes.length}');

      // Print all recipes
      for (var recipe in recipes) {
        debugPrint('Recipe Name: ${recipe.name}');
        debugPrint('Calories: ${recipe.calories}');
        debugPrint('Description: ${recipe.description}');
        debugPrint('Ingredients: ${recipe.ingredients}');
        debugPrint('Steps: ${recipe.steps?.join(", ")}');
        debugPrint('-----------------------------');
      }

      emit(RecipesRecommendationSuccessState(recipes));

    }).catchError((error){
      print(error.toString());
      emit(RecipesRecommendationErrorState(error.toString()));
    });

  }


  /*Recommend from history */


  List<RecipeRecommendation> historyRecipes = [];


  void getRecommendedRecipesFromHistory ({
    int numOfRecipes = 1,
    int minCalories = 200,
    int maxCalories = 800,
    bool diabeticFriendly = false,
    int maxPrepTime = 60,
  })
  {
    emit(RecipeRecommendationFromHistoryLoadingState());

    DioHelper.postData3(
      url: 'recommend_recipe_by_user_history/$user_id',
      data:{
        'num_recipes' : numOfRecipes,
        'min_calories': minCalories,
        'max_calories': maxCalories,
        'diabetic_friendly': diabeticFriendly,
        'max_prep_time': maxPrepTime,
      },
    ).then((value){

      final data = value?.data;

      if (data == null || data['recipes'] == null || data['recipes'].isEmpty) {
        emit(RecipeRecommendationFromHistoryEmptyState('No recipes found'));
        return;
      }

      historyRecipes = (data['recipes'] as List)
          .map((recipe) => RecipeRecommendation.fromJson(recipe))
          .toList();

      print('Number of recommended recipes: ${recipes.length}');

      // Print all recipes
      for (var recipe in recipes) {
        debugPrint('Recipe Name: ${recipe.name}');
        debugPrint('Calories: ${recipe.calories}');
        debugPrint('Description: ${recipe.description}');
        debugPrint('Ingredients: ${recipe.ingredients}');
        debugPrint('Steps: ${recipe.steps?.join(", ")}');
        debugPrint('-----------------------------');
      }

      emit(RecipeRecommendationFromHistorySuccessState(historyRecipes));

    }).catchError((error){
      print(error.toString());
      emit(RecipeRecommendationFromHistoryErrorState(error.toString()));
    });

  }





  AddRecipeToUserHistory? addRecipeToUserHistoryMessage;

  void addRecipeToUserHistory ({
    required double calories,
    required double carbohydrates,
    required String recipeDescription,
    required String ingredients,
    required int minutes,
    required int numOfSteps,
    required int numOfIngredients,
    required String name,
    required double protein,
    required double saturatedFat,
    required double similarity,
    required double sodium,
    required List<String> steps,
    required double sugar,
    required double fat,

  })
  {
    emit(AddRecipeToHistoryLoadingState());

    String stepsJsonString = jsonEncode(steps);

    DioHelper.postData3(
      url: 'add_recipe_to_history/$user_id',
      data:{
        'calories': calories,
        'carbohydrates (PDV)': carbohydrates,
        'description': recipeDescription,
        'ingredients': ingredients,
        'minutes': minutes,
        'n_ingredients': numOfIngredients,
        'n_steps': numOfSteps,
        'name': name,
        'protein (PDV)': protein,
        'saturated fats (PDV)': saturatedFat,
        'similarity': similarity,
        'sodium (PDV)': sodium,
        'steps': stepsJsonString,
        'sugar (PDV)': sugar,
        'total fats (PDV)': fat,

      },
    ).then((value){

      addRecipeToUserHistoryMessage = AddRecipeToUserHistory.fromJson(value?.data);

      print('Recipe added to history: ${addRecipeToUserHistoryMessage?.message}');

      emit(AddRecipeToHistorySuccessState(addRecipeToUserHistoryMessage!.message!));

    }).catchError((error){
      print(error.toString());
      emit(AddRecipeToHistoryErrorState(error.toString()));
    });

  }

  List<GetUserRecipeHistory> hRecipes = [];

  void getUserRecipeHistory(){

    emit(GetUserRecipeHistoryLoadingState());

    DioHelper.getData3(
      url: 'get_user_recipes_history/$user_id',
    ).then((value){

      final data = value?.data;

      if (data == null || data.isEmpty) {
        emit(GetUserRecipeHistoryEmptyState());
        return;
      }

      hRecipes = (data as List)
          .map((recipe) => GetUserRecipeHistory.fromJson(recipe))
          .toList();

      print('Number of user recipe history: ${hRecipes.length}');

      emit(GetUserRecipeHistorySuccessState(hRecipes));

    }).catchError((error){
      print(error.toString());
      emit(GetUserRecipeHistoryErrorState(error.toString()));
    });

  }
}