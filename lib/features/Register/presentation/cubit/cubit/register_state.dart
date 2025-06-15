abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterLoadingState extends RegisterState {}

class VerificationCodeLoadingState extends RegisterState {}


class VerificationCodeSuccessState extends RegisterState {
  final String message;

  VerificationCodeSuccessState(this.message);
}


class VerificationCodeErrorState extends RegisterState {
  final String error;

  VerificationCodeErrorState(this.error);
}




class EmailVerifiedLoadingState extends RegisterState {}


class EmailVerifiedSuccessState extends RegisterState {
  final String message;

  EmailVerifiedSuccessState(this.message);
}


class EmailVerifiedErrorState extends RegisterState {
  final String error;

  EmailVerifiedErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterState {}




// part of 'register_cubit.dart';
//
// @immutable
// abstract class RegisterState {}
//
// class RegisterInitial extends RegisterState {}
//
// class RegisterStep1 extends RegisterState {
//   final RegisterData registerData;
//
//   RegisterStep1(this.registerData);
// }
//
// class RegisterStep2 extends RegisterState {
//   final RegisterData registerData;
//
//   RegisterStep2(this.registerData);
// }
//
// class RegisterStep3 extends RegisterState {
//   final RegisterData registerData;
//
//   RegisterStep3(this.registerData);
// }
//
// class RegisterStep3_1 extends RegisterState {
//   final RegisterData registerData;
//
//   RegisterStep3_1(this.registerData);
// }
//
// class RegisterStep3_2 extends RegisterState {
//   final RegisterData registerData;
//
//   RegisterStep3_2(this.registerData);
// }
//
// class RegisterStep3_3 extends RegisterState {
//   final RegisterData registerData;
//
//   RegisterStep3_3(this.registerData);
// }
//
// class RegisterComplete extends RegisterState {
//   final RegisterData registerData;
//
//   RegisterComplete(this.registerData);
// }

