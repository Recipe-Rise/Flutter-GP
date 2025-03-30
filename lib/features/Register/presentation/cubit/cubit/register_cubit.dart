import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/features/Register/data/Models/register_data.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  // Private field
  final RegisterData _registerData = RegisterData(
    firstName: " ",
    lastName: " ",
    email: " ",
    password: " ",
    dateOfBirth: DateTime.now(),
  );

  // Public getter for _registerData
  RegisterData get registerData => _registerData;

  void goToStep1() {
    emit(RegisterStep1(_registerData));
  }

  void goToStep2() {
    emit(RegisterStep2(_registerData));
  }

  void goToStep3() {
    emit(RegisterStep3(_registerData));
  }

  void goToStep3_1() {
    emit(RegisterStep3_1(_registerData));
  }

  void goToStep3_2() {
    emit(RegisterStep3_2(_registerData));
  }

  void goToStep3_3() {
    emit(RegisterStep3_3(_registerData));
  }

  void completeRegistration() {
    emit(RegisterComplete(_registerData));
  }

  void updateFirstName(String firstName) {
    _registerData.firstName = firstName;
  }

  void updateLastName(String lastName) {
    _registerData.lastName = lastName;
  }

  void updateEmail(String email) {
    _registerData.email = email;
  }

  void updatePassword(String password) {
    _registerData.password = password;
  }

  void updateGender(String gender) {
    _registerData.gender = gender;
  }

  void updateDateOfBirth(DateTime dateOfBirth) {
    _registerData.dateOfBirth = dateOfBirth;
  }

  void updateWeight(double weight) {
    _registerData.weight = weight;
  }

  void updateHeight(double height) {
    _registerData.height = height;
  }

  void updateGoal(String goal) {
    _registerData.goal = goal;
  }

  // Calculate BMI
  double calculateBMI() {
    if (_registerData.weight <= 0 || _registerData.height <= 0) {
      return 0.0; // Return 0 instead of throwing exception
    }
    return _registerData.weight /
        ((_registerData.height / 100) * (_registerData.height / 100));
  }

  // Calculate BMR
  double calculateBMR() {
    if (_registerData.weight <= 0 ||
        _registerData.height <= 0 ||
        _registerData.gender.isEmpty) {
      return 0.0; // Return 0 instead of throwing exception
    }

    final age = DateTime.now().year - _registerData.dateOfBirth.year;
    if (_registerData.gender == 'Male') {
      return 88.362 +
          (13.397 * _registerData.weight) +
          (4.799 * _registerData.height) -
          (5.677 * age);
    } else {
      return 447.593 +
          (9.247 * _registerData.weight) +
          (3.098 * _registerData.height) -
          (4.330 * age);
    }
  }
}
