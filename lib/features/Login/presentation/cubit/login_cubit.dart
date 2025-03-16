import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading()); // Emit loading state
    try {
      // Simulate an API call with a delay
      await Future.delayed(const Duration(seconds: 2));

      // Check if email contains "@gmail.com"
      if (email.contains("@gmail.com")) {
        emit(LoginSuccess()); // Emit success state
      } else {
        emit(LoginFailure(
            "Invalid email. Please use a Gmail account.")); // Emit failure state
      }
    } catch (e) {
      emit(LoginFailure(
          "An error occurred: ${e.toString()}")); // Emit failure state
    }
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}
