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
  });
}
