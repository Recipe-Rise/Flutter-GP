class LoginModel {
  late String email;
  late String message;
  late String name;
  late int userId;

  LoginModel({
    required this.email,
    required this.message,
    required this.name,
    required this.userId,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? '';
    message = json['message'] ?? '';
    name = json['name'] ?? '';
    userId = json['user_id'] !=null ? json['user_id'] : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['message'] = this.message;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    return data;
  }

}