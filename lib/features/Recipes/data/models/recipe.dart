class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final int calories;
  final int prepTimeMinutes;
  final String category;
  final List<String> tags;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.calories,
    required this.prepTimeMinutes,
    required this.category,
    this.tags = const [],
  });

  get nutritionInfo => null;
}
