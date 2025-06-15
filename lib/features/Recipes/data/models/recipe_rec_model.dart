class RecipeRecommendation {
  double? calories;
  double? carbohydratesPDV;
  String? description;
  String? ingredients;
  int? minutes;
  int? nIngredients;
  int? nSteps;
  String? name;
  double? proteinPDV;
  double? saturatedFatPDV;
  double? similarity;
  double? sodiumPDV;
  List<String>? steps;
  double? sugarPDV;
  double? totalFatPDV;

  RecipeRecommendation(
      {this.calories,
        this.carbohydratesPDV,
        this.description,
        this.ingredients,
        this.minutes,
        this.nIngredients,
        this.nSteps,
        this.name,
        this.proteinPDV,
        this.saturatedFatPDV,
        this.similarity,
        this.sodiumPDV,
        this.steps,
        this.sugarPDV,
        this.totalFatPDV});

  RecipeRecommendation.fromJson(Map<String, dynamic> json) {
    calories = (json['calories'] as num?)?.toDouble();
    carbohydratesPDV = (json['carbohydrates (PDV)'] as num?)?.toDouble();
    description = json['description'];
    ingredients = json['ingredients'];
    minutes = (json['minutes'] as num?)?.toInt();
    nIngredients = (json['n_ingredients'] as num?)?.toInt();
    nSteps = (json['n_steps'] as num?)?.toInt();
    name = json['name'];
    proteinPDV = (json['protein (PDV)'] as num?)?.toDouble();
    saturatedFatPDV = (json['saturated fat (PDV)'] as num?)?.toDouble();
    similarity = (json['similarity'] as num?)?.toDouble();
    sodiumPDV = (json['sodium (PDV)'] as num?)?.toDouble();
    steps = json['steps']?.cast<String>();
    sugarPDV = (json['sugar (PDV)'] as num?)?.toDouble();
    totalFatPDV = (json['total fat (PDV)'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories'] = this.calories;
    data['carbohydrates (PDV)'] = this.carbohydratesPDV;
    data['description'] = this.description;
    data['ingredients'] = this.ingredients;
    data['minutes'] = this.minutes;
    data['n_ingredients'] = this.nIngredients;
    data['n_steps'] = this.nSteps;
    data['name'] = this.name;
    data['protein (PDV)'] = this.proteinPDV;
    data['saturated fat (PDV)'] = this.saturatedFatPDV;
    data['similarity'] = this.similarity;
    data['sodium (PDV)'] = this.sodiumPDV;
    data['steps'] = this.steps;
    data['sugar (PDV)'] = this.sugarPDV;
    data['total fat (PDV)'] = this.totalFatPDV;
    return data;
  }
}