class GetUserRecipeHistory {
  double? calories;
  double? carbohydratesPDV;
  String? dateAndTime;
  String? description;
  String? ingredients;
  double? minutes;
  int? nIngredients;
  int? nSteps;
  String? name;
  double? proteinPDV;
  int? recipeId;
  double? saturatedFatsPDV;
  double? similarity;
  double? sodiumPDV;
  List<String>? steps;
  double? sugarPDV;
  double? totalFatsPDV;
  int? userId;

  GetUserRecipeHistory(
      {this.calories,
        this.carbohydratesPDV,
        this.dateAndTime,
        this.description,
        this.ingredients,
        this.minutes,
        this.nIngredients,
        this.nSteps,
        this.name,
        this.proteinPDV,
        this.recipeId,
        this.saturatedFatsPDV,
        this.similarity,
        this.sodiumPDV,
        this.steps,
        this.sugarPDV,
        this.totalFatsPDV,
        this.userId});

  GetUserRecipeHistory.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbohydratesPDV = json['carbohydrates (PDV)'];
    dateAndTime = json['date_and_time'];
    description = json['description'];
    ingredients = json['ingredients'];
    minutes = json['minutes'];
    nIngredients = json['n_ingredients'];
    nSteps = json['n_steps'];
    name = json['name'];
    proteinPDV = json['protein (PDV)'];
    recipeId = json['recipe_id'];
    saturatedFatsPDV = json['saturated fats (PDV)'];
    similarity = json['similarity'];
    sodiumPDV = json['sodium (PDV)'];
    steps = json['steps'].cast<String>();
    sugarPDV = json['sugar (PDV)'];
    totalFatsPDV = json['total fats (PDV)'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories'] = this.calories;
    data['carbohydrates (PDV)'] = this.carbohydratesPDV;
    data['date_and_time'] = this.dateAndTime;
    data['description'] = this.description;
    data['ingredients'] = this.ingredients;
    data['minutes'] = this.minutes;
    data['n_ingredients'] = this.nIngredients;
    data['n_steps'] = this.nSteps;
    data['name'] = this.name;
    data['protein (PDV)'] = this.proteinPDV;
    data['recipe_id'] = this.recipeId;
    data['saturated fats (PDV)'] = this.saturatedFatsPDV;
    data['similarity'] = this.similarity;
    data['sodium (PDV)'] = this.sodiumPDV;
    data['steps'] = this.steps;
    data['sugar (PDV)'] = this.sugarPDV;
    data['total fats (PDV)'] = this.totalFatsPDV;
    data['user_id'] = this.userId;
    return data;
  }
}
