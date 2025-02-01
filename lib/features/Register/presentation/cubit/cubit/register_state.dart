part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterStep1 extends RegisterState {
  final RegisterData registerData;

  RegisterStep1(this.registerData);
}

class RegisterStep2 extends RegisterState {
  final RegisterData registerData;

  RegisterStep2(this.registerData);
}

class RegisterStep3 extends RegisterState {
  final RegisterData registerData;

  RegisterStep3(this.registerData);
}

class RegisterStep3_1 extends RegisterState {
  final RegisterData registerData;

  RegisterStep3_1(this.registerData);
}

class RegisterStep3_2 extends RegisterState {
  final RegisterData registerData;

  RegisterStep3_2(this.registerData);
}

class RegisterStep3_3 extends RegisterState {
  final RegisterData registerData;

  RegisterStep3_3(this.registerData);
}

class RegisterComplete extends RegisterState {
  final RegisterData registerData;

  RegisterComplete(this.registerData);
}
