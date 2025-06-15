import '../../data/models/get_user_recipes_history.dart';
import '../../data/models/recipe_rec_model.dart';

abstract class RecipesRecommendationStates {}

class RecipesRecommendationInitialState extends RecipesRecommendationStates {}

class RecipesRecommendationLoadingState extends RecipesRecommendationStates {}

class RecipesRecommendationSuccessState extends RecipesRecommendationStates {
  final List<RecipeRecommendation> recipes;

  RecipesRecommendationSuccessState(this.recipes);
}

class RecipesRecommendationErrorState extends RecipesRecommendationStates {
  final String error;

  RecipesRecommendationErrorState(this.error);
}

class RecipesRecommendationEmptyState extends RecipesRecommendationStates {
  final String message;

  RecipesRecommendationEmptyState(this.message);
}

class AddRecipeToHistoryLoadingState extends RecipesRecommendationStates {}

class AddRecipeToHistorySuccessState extends RecipesRecommendationStates {
  final String message;

  AddRecipeToHistorySuccessState(this.message);
}



class AddRecipeToHistoryErrorState extends RecipesRecommendationStates {
  final String error;

  AddRecipeToHistoryErrorState(this.error);
}

class GetUserRecipeHistoryLoadingState extends RecipesRecommendationStates {}

class GetUserRecipeHistorySuccessState extends RecipesRecommendationStates {
  final List<GetUserRecipeHistory> hRecipes;

  GetUserRecipeHistorySuccessState(this.hRecipes);
}

class GetUserRecipeHistoryErrorState extends RecipesRecommendationStates {
  final String error;

  GetUserRecipeHistoryErrorState(this.error);
}

class GetUserRecipeHistoryEmptyState extends RecipesRecommendationStates {}

class RecipeRecommendationFromHistoryLoadingState extends RecipesRecommendationStates {}

class RecipeRecommendationFromHistorySuccessState extends RecipesRecommendationStates {
  final List<RecipeRecommendation> recipes;

  RecipeRecommendationFromHistorySuccessState(this.recipes);
}

class RecipeRecommendationFromHistoryErrorState extends RecipesRecommendationStates {
  final String error;

  RecipeRecommendationFromHistoryErrorState(this.error);
}

class RecipeRecommendationFromHistoryEmptyState extends RecipesRecommendationStates {
  final String message;

  RecipeRecommendationFromHistoryEmptyState(this.message);
}