class CalorieSummary {
  final int consumed;
  final int total;
  final int remaining;
  final int burned;

  CalorieSummary({
    required this.consumed,
    required this.total,
    required this.remaining,
    required this.burned,
  });
}

class Macronutrient {
  final String name;
  final int current;
  final int goal;
  final int percentage;
  final MacroType type;

  Macronutrient({
    required this.name,
    required this.current,
    required this.goal,
    required this.percentage,
    required this.type,
  });
}

enum MacroType { protein, carbs, fat }

class Meal {
  final String name;
  final String description;
  final int calories;
  final MealType type;

  Meal({
    required this.name,
    required this.description,
    required this.calories,
    required this.type,
  });
}

enum MealType { breakfast, lunch, dinner, snack }