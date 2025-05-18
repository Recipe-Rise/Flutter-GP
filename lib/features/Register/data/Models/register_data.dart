class RegisterModel {
  String? message;

  RegisterModel({this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
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
  });
}
