import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String apiKey = 'AIzaSyDqD4sNw6JRqceUmfeywJYbOhpQzNN9YFk';
  late final GenerativeModel model;

  GeminiService() {
    // Initialize the model
    model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
  }

  Future<String> getRecipeRecommendations(String userPreferences) async {
    try {
      final prompt = '''
      Act as a nutrition expert. 
      Based on these user preferences and dietary requirements: $userPreferences
      Recommend 3 healthy recipes with ingredients and preparation steps.
      Format the output clearly with recipe names as headings.
      Include estimated preparation time and nutritional information for each recipe.
      ''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text ?? 'No recommendations available';
    } catch (e) {
      debugPrint('Recipe recommendation error: $e');
      return 'Error getting recommendations. Please check your internet connection and try again.';
    }
  }

  Future<String> getWorkoutPlan(String userFitness) async {
    try {
      final prompt = '''
      Act as a fitness coach.
      Based on this user's fitness level and goals: $userFitness
      Create a personalized workout plan for one week.
      Include exercise types, sets, reps, duration, and rest periods.
      Format the output with days as headings and clear instructions.
      ''';

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text ?? 'No workout plan available';
    } catch (e) {
      debugPrint('Workout plan error: $e');
      return 'Error creating workout plan. Please check your internet connection and try again.';
    }
  }
}
