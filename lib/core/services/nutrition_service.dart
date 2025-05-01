import 'package:fitfork_gp/features/Home/data/models/nutrition_model.dart';

class NutritionService {
  // Get calorie summary for the current day
  Future<CalorieSummary> getCalorieSummary() async {
    // Mock implementation - in a real app, this would fetch data from an API or local database
    return CalorieSummary(
      consumed: 760,
      total: 2000,
      remaining: 1240,
      burned: 320,
    );
  }

  // Get macronutrient data for the current day
  Future<List<Macronutrient>> getMacronutrients() async {
    return [
      Macronutrient(
        name: 'Proteins',
        current: 27,
        goal: 75,
        percentage: 36,
        type: MacroType.protein,
      ),
      Macronutrient(
        name: 'Carbs',
        current: 96,
        goal: 250,
        percentage: 38,
        type: MacroType.carbs,
      ),
      Macronutrient(
        name: 'Fats',
        current: 22,
        goal: 67,
        percentage: 33,
        type: MacroType.fat,
      ),
    ];
  }

  // Get meals for the current day
  Future<List<Meal>> getMeals() async {
    return [
      Meal(
        name: 'Breakfast',
        description: 'Toast, eggs, coffee',
        calories: 320,
        type: MealType.breakfast,
      ),
    ];
  }

  // Add a new meal
  Future<void> addMeal(Meal meal) async {
    // In a real implementation, this would update a database
  }

  // Add burned calories from exercise
  Future<void> addExercise(int calories) async {
    // In a real implementation, this would update a database
  }
}
