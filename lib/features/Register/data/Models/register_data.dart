class RegisterModel {
  String? activityLevel;
  int? age;
  String? bmi;
  String? bmr;
  String? email;
  String? fitnessGoal;
  String? gender;
  String? height;
  String? message;
  String? name;
  int? userId;
  String? weight;

  RegisterModel(
      {this.activityLevel,
        this.age,
        this.bmi,
        this.bmr,
        this.email,
        this.fitnessGoal,
        this.gender,
        this.height,
        this.message,
        this.name,
        this.userId,
        this.weight});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    activityLevel = json['activity_level'];
    age = json['age'];
    bmi = json['bmi'];
    bmr = json['bmr'];
    email = json['email'];
    fitnessGoal = json['fitness_goal'];
    gender = json['gender'];
    height = json['height'];
    message = json['message'];
    name = json['name'];
    userId = json['user_id'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity_level'] = this.activityLevel;
    data['age'] = this.age;
    data['bmi'] = this.bmi;
    data['bmr'] = this.bmr;
    data['email'] = this.email;
    data['fitness_goal'] = this.fitnessGoal;
    data['gender'] = this.gender;
    data['height'] = this.height;
    data['message'] = this.message;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['weight'] = this.weight;
    return data;
  }
}

// static data

class RegisterData {
  String firstName;
  String lastName;
  String email;
  String password;
  String gender;
  DateTime dateOfBirth;
  double weight;
  double height;
  String goal;
  int age = 0;
  String activityLevel = '';
  String fitnessGoal = '';

  RegisterData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.gender = '',
    required this.dateOfBirth,
    this.weight = 0.0,
    this.height = 0.0,
    this.goal = '',
    this.age = 0,
    this.activityLevel = '',
    this.fitnessGoal = '',
  });
}
