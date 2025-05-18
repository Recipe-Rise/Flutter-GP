class GetUserData {
  int? age;
  String? bmi;
  String? bmr;
  String? email;
  String? gender;
  String? height;
  String? name;
  int? userId;
  String? weight;
  String? activity_level;
  String? fitness_goal;

  GetUserData(
      {this.age,
        this.bmi,
        this.bmr,
        this.email,
        this.gender,
        this.height,
        this.name,
        this.userId,
        this.weight,
        this.activity_level,
        this.fitness_goal,
      });

  GetUserData.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    bmi = json['bmi'];
    bmr = json['bmr'];
    email = json['email'];
    gender = json['gender'];
    height = json['height'];
    name = json['name'];
    userId = json['user_id'];
    weight = json['weight'];
    activity_level = json['activity_level'];
    fitness_goal = json['fitness_goal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['bmi'] = this.bmi;
    data['bmr'] = this.bmr;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['weight'] = this.weight;
    data['activity_level'] = this.activity_level;
    data['fitness_goal'] = this.fitness_goal;
    return data;
  }
}
