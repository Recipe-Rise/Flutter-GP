class NutritionInfo {
  final int calories;
  final String protein;
  final String carbs;
  final String fat;
  final String sugar;

  NutritionInfo(
    this.sugar, {
    this.calories = 400,
    this.protein = "20 g",
    this.carbs = "50 g",
    this.fat = "10 g",
  });
}
