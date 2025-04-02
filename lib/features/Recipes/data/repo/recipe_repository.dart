import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';

class RecipeRepository {
  // Mock data - in a real app, this would come from an API or local database
  List<Recipe> getRecipes(String category) {
    // Sample recipes for demonstration
    final Map<String, List<Recipe>> recipesByCategory = {
      'breakfast': [
        Recipe(
          id: 'b1',
          name: 'Avocado Toast with Eggs',
          imageUrl: 'assets/images/recipes/avocado_toast.jpg',
          ingredients: [
            '2 slices whole grain bread',
            '1 ripe avocado',
            '2 eggs',
            'Salt and pepper to taste',
            'Red pepper flakes (optional)',
          ],
          instructions: [
            'Toast the bread until golden and firm.',
            'Mash the avocado in a bowl and season with salt and pepper.',
            'Spread the mashed avocado on the toast.',
            'Poach or fry the eggs to your liking.',
            'Place the eggs on top of the avocado toast.',
            'Sprinkle with additional salt, pepper, and red pepper flakes if desired.',
          ],
          calories: 350,
          prepTimeMinutes: 15,
          category: 'breakfast',
          tags: ['Healthy', 'Quick & Easy'],
        ),
        Recipe(
          id: 'b2',
          name: 'Greek Yogurt with Berries',
          imageUrl: 'assets/images/recipes/greek_yogurt.jpg',
          ingredients: [
            '1 cup Greek yogurt',
            '1/2 cup mixed berries',
            '1 tablespoon honey',
            '2 tablespoons granola',
          ],
          instructions: [
            'Add Greek yogurt to a bowl.',
            'Top with mixed berries, honey, and granola.',
            'Mix if desired and enjoy immediately.',
          ],
          calories: 220,
          prepTimeMinutes: 5,
          category: 'breakfast',
          tags: ['Quick & Easy', 'Healthy'],
        ),
        Recipe(
          id: 'b3',
          name: 'Spinach and Cheese Omelette',
          imageUrl: 'assets/images/recipes/spinach_omelette.jpg',
          ingredients: [
            '3 eggs',
            '1 cup fresh spinach',
            '1/4 cup shredded cheese',
            '1 tablespoon olive oil',
            'Salt and pepper to taste',
          ],
          instructions: [
            'Beat eggs in a bowl with salt and pepper.',
            'Heat olive oil in a non-stick pan over medium heat.',
            'Add spinach and cook until wilted, about 1 minute.',
            'Pour in egg mixture and cook until edges set.',
            'Sprinkle cheese on one half and fold omelette.',
            'Cook until cheese melts and eggs are set.',
          ],
          calories: 320,
          prepTimeMinutes: 10,
          category: 'breakfast',
          tags: ['Quick & Easy', 'Healthy'],
        ),
        Recipe(
          id: 'b4',
          name: 'Banana Pancakes',
          imageUrl: 'assets/images/recipes/banana_pancakes.jpg',
          ingredients: [
            '1 ripe banana',
            '2 eggs',
            '1/4 cup oats',
            '1/2 teaspoon cinnamon',
            '1 tablespoon maple syrup',
          ],
          instructions: [
            'Mash banana in a bowl.',
            'Mix in eggs, oats, and cinnamon until well combined.',
            'Heat a non-stick pan over medium heat.',
            'Pour small amounts of batter to form pancakes.',
            'Cook until bubbles form, then flip and cook other side.',
            'Serve with maple syrup.',
          ],
          calories: 280,
          prepTimeMinutes: 15,
          category: 'breakfast',
          tags: ['Gourmet', 'Healthy'],
        ),
      ],
      'lunch': [
        Recipe(
          id: 'l1',
          name: 'Chicken Caesar Salad',
          imageUrl: 'assets/images/recipes/caesar_salad.jpg',
          ingredients: [
            '2 cups romaine lettuce, chopped',
            '4 oz grilled chicken breast, sliced',
            '2 tablespoons Caesar dressing',
            '1/4 cup croutons',
            '2 tablespoons grated Parmesan cheese',
          ],
          instructions: [
            'Wash and chop the romaine lettuce.',
            'Grill the chicken breast and slice into strips.',
            'Combine lettuce and chicken in a bowl.',
            'Add Caesar dressing and toss to coat.',
            'Top with croutons and Parmesan cheese.',
          ],
          calories: 320,
          prepTimeMinutes: 20,
          category: 'lunch',
          tags: ['Healthy', 'Quick & Easy'],
        ),
        Recipe(
          id: 'l2',
          name: 'Turkey and Avocado Wrap',
          imageUrl: 'assets/images/recipes/turkey_wrap.jpg',
          ingredients: [
            '1 whole wheat tortilla',
            '3 oz sliced turkey breast',
            '1/2 avocado, sliced',
            '1/4 cup shredded lettuce',
            '2 slices tomato',
            '1 tablespoon mustard',
          ],
          instructions: [
            'Lay tortilla flat on a plate.',
            'Spread mustard evenly over tortilla.',
            'Layer turkey, avocado, lettuce, and tomato.',
            'Roll up tightly and cut in half.',
          ],
          calories: 290,
          prepTimeMinutes: 10,
          category: 'lunch',
          tags: ['Quick & Easy'],
        ),
      ],
      'dinner': [
        Recipe(
          id: 'd1',
          name: 'Baked Salmon with Vegetables',
          imageUrl: 'assets/images/recipes/baked_salmon.jpg',
          ingredients: [
            '6 oz salmon fillet',
            '1 cup broccoli florets',
            '1 cup sliced carrots',
            '1 tablespoon olive oil',
            '1 lemon, sliced',
            'Salt and pepper to taste',
            '1 teaspoon dried herbs (thyme, rosemary, or dill)',
          ],
          instructions: [
            'Preheat oven to 400°F (200°C).',
            'Place salmon on a baking sheet lined with parchment paper.',
            'Arrange vegetables around the salmon.',
            'Drizzle everything with olive oil and season with salt, pepper, and herbs.',
            'Top salmon with lemon slices.',
            'Bake for 15-20 minutes until salmon is cooked through and vegetables are tender.',
          ],
          calories: 380,
          prepTimeMinutes: 30,
          category: 'dinner',
          tags: ['Healthy', 'Gourmet'],
        ),
        Recipe(
          id: 'd2',
          name: 'Vegetable Stir Fry with Tofu',
          imageUrl: 'assets/images/recipes/tofu_stirfry.jpg',
          ingredients: [
            '8 oz firm tofu, cubed',
            '2 cups mixed vegetables (bell peppers, broccoli, carrots, snap peas)',
            '2 cloves garlic, minced',
            '1 tablespoon ginger, grated',
            '2 tablespoons soy sauce',
            '1 tablespoon sesame oil',
            '1 teaspoon cornstarch',
            '2 tablespoons water',
          ],
          instructions: [
            'Press tofu to remove excess water, then cut into cubes.',
            'Heat sesame oil in a wok or large skillet over medium-high heat.',
            'Add tofu and cook until golden, about 5 minutes.',
            'Add garlic and ginger, stir for 30 seconds.',
            'Add vegetables and stir fry for 5-7 minutes until crisp-tender.',
            'Mix soy sauce, cornstarch, and water in a small bowl.',
            'Pour sauce over stir fry and cook for 1-2 minutes until thickened.',
            'Serve hot, optionally over rice or noodles.',
          ],
          calories: 310,
          prepTimeMinutes: 25,
          category: 'dinner',
          tags: ['Healthy', 'Quick & Easy'],
        ),
      ],
    };

    return recipesByCategory[category] ?? [];
  }

  List<Recipe> getRandomRecipes() {
    final allRecipes = [
      ...getRecipes('breakfast'),
      ...getRecipes('lunch'),
      ...getRecipes('dinner'),
    ];

    // In a real app, you would randomize this
    return allRecipes.take(3).toList();
  }

  // New method to filter recipes based on user preferences
  List<Recipe> getFilteredRecipes({
    required String category,
    List<String>? ingredients,
    String? mealType,
    int? maxPrepTime,
    List<int>? caloriesRange,
  }) {
    // Get all recipes for the category
    List<Recipe> allRecipes = getRecipes(category);

    // Apply filters
    return allRecipes.where((recipe) {
      // Filter by ingredients if provided
      if (ingredients != null && ingredients.isNotEmpty) {
        bool hasMatchingIngredient = false;
        for (var ingredient in ingredients) {
          if (recipe.ingredients.any((recipeIngredient) => recipeIngredient
              .toLowerCase()
              .contains(ingredient.toLowerCase()))) {
            hasMatchingIngredient = true;
            break;
          }
        }
        if (!hasMatchingIngredient) return false;
      }

      // Filter by meal type if provided
      if (mealType != null && mealType.isNotEmpty) {
        if (!recipe.tags.contains(mealType)) return false;
      }

      // Filter by preparation time if provided
      if (maxPrepTime != null) {
        if (recipe.prepTimeMinutes > maxPrepTime) return false;
      }

      // Filter by calories range if provided
      if (caloriesRange != null && caloriesRange.length == 2) {
        int minCalories = caloriesRange[0];
        int maxCalories = caloriesRange[1];
        if (recipe.calories < minCalories || recipe.calories > maxCalories)
          return false;
      }

      return true;
    }).toList();
  }
}
