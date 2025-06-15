import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/features/Register/data/Models/register_data.dart';
import 'package:fitfork_gp/features/Register/data/Models/send_verification_code_model.dart';
import 'package:fitfork_gp/features/Register/data/Models/verify_email_model.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_state.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../constants.dart';
import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../../shared/network/remote/dio_helper.dart';


class RegisterCubit extends Cubit<RegisterState> {

  RegisterCubit() : super(RegisterInitial());


  static RegisterCubit get(context) => BlocProvider.of(context);


  SendVerificationCodeModel? sendVerificationCodeModel;

  void sendEmailVerificationCode({
    required String email,

  }) {
    emit(VerificationCodeLoadingState());

    DioHelper.postData3(
      url: 'send_verification_code',
      data: {

        'email': email,

      },
    ).then((value) {
      final data = value?.data;

      sendVerificationCodeModel = SendVerificationCodeModel.fromJson(value?.data);

      emit(VerificationCodeSuccessState(sendVerificationCodeModel!.message!));

    }).catchError((error) {
      print(error.toString());
      emit(VerificationCodeErrorState(error.toString()));
    });
  }


  EmailVerifiedModel? emailVerifiedModel;

  void emailVerify({
    required String email,
    required String secretCode,

  }) {
    emit(EmailVerifiedLoadingState());

    DioHelper.postData3(
      url: 'verify_email',
      data: {

        'email': email,
        'secret_code' : secretCode

      },
    ).then((value) {
      final data = value?.data;

      emailVerifiedModel = EmailVerifiedModel.fromJson(value?.data);

      emit(EmailVerifiedSuccessState(emailVerifiedModel!.message!));

      print(email);

    }).catchError((error) {
      print(error.toString());
      emit(EmailVerifiedErrorState(error.toString()));
    });
  }




  RegisterModel? registerModel;

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required int age,
    required String gender,
    required double weight,
    required double height,
    required String activityLevel,
    required String fitnessGoal,
    required context,
  }) async {
    emit(RegisterLoadingState());

    DioHelper.postData3(
        url: 'api/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'age' : age,
          'gender' : gender,
          'height' : height,
          'weight' : weight,
          'activity_level' : activityLevel,
          'fitness_goal' : fitnessGoal,
        }
    ).then((value) {

      print(value?.data);

      registerModel = RegisterModel.fromJson(value?.data);

      print('Parsed User ID: ${registerModel?.userId}');
      print('Parsed User Name: ${registerModel?.name}');

      CacheHelper.saveData(key: 'user_id', value: registerModel?.userId);

      // user_id = CacheHelper.getData(key: 'user_id');
      // if (user_id != null) {
      //   print('Logged-in User ID: $user_id');
      //   AppCubit.get(context).GetAllUserData();
      // }

      emit(RegisterSuccessState());

    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    }); // Emit loading state

  }


  late RegisterData _registerData = RegisterData(
    firstName: "",
    lastName: "",
    email: "",
    password: "",
    dateOfBirth: DateTime.now(),
    age: 0,
    gender: "",
    weight: 0.0,
    height: 0.0,
  );

  RegisterData get registerData => _registerData;

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

    // Calculate age based on the date of birth
    final DateTime today = DateTime.now();
    int age = today.year - dateOfBirth.year;
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    _registerData.age = age;
  }

  void updateWeight(double weight) {
    _registerData.weight = weight;
  }

  void updateHeight(double height) {
    _registerData.height = height;
  }

  void updateActivityLevel(String activityLevel) {
    _registerData.activityLevel = activityLevel;
  }

  void updateFitnessGoal(String fitnessGoal) {
    _registerData.fitnessGoal = fitnessGoal;
  }



  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }


}


  //
  // void completeRegistration() {
  //   emit(RegisterComplete(_registerData));
  // }


//   late RegisterData _registerData = RegisterData(
//     firstName: " ",
//     lastName: " ",
//     email: " ",
//     password: " ",
//     dateOfBirth: DateTime.now(),
//     age: 0,
//     gender: " ",
//   );
//
//   // Public getter for _registerData
//   RegisterData get registerData => _registerData;
//
//   void goToStep1() {
//     emit(RegisterStep1(_registerData));
//   }
//
//   void goToStep2() {
//     emit(RegisterStep2(_registerData));
//   }
//
//   void goToStep3() {
//     emit(RegisterStep3(_registerData));
//   }
//
//   void goToStep3_1() {
//     emit(RegisterStep3_1(_registerData));
//   }
//
//   void goToStep3_2() {
//     emit(RegisterStep3_2(_registerData));
//   }
//
//   void goToStep3_3() {
//     emit(RegisterStep3_3(_registerData));
//   }
//
//   void completeRegistration() {
//     emit(RegisterComplete(_registerData));
//   }
//
//   void updateFirstName(String firstName) {
//     _registerData.firstName = firstName;
//   }
//
//   void updateLastName(String lastName) {
//     _registerData.lastName = lastName;
//   }
//
//   void updateEmail(String email) {
//     _registerData.email = email;
//   }
//
//   void updatePassword(String password) {
//     _registerData.password = password;
//   }
//
//   void updateGender(String gender) {
//     _registerData.gender = gender;
//   }
//
//   void updateDateOfBirth(DateTime dateOfBirth) {
//     _registerData.dateOfBirth = dateOfBirth;
//   }
//
//   void updateWeight(double weight) {
//     _registerData.weight = weight;
//   }
//
//   void updateHeight(double height) {
//     _registerData.height = height;
//   }
//
//   void updateGoal(String goal) {
//     _registerData.goal = goal;
//   }
//
//   void calculateAge (int age ){
//     _registerData = age as RegisterData ;
//   }
//
//   // Calculate BMI
//   double calculateBMI() {
//     if (_registerData.weight <= 0 || _registerData.height <= 0) {
//       return 0.0; // Return 0 instead of throwing exception
//     }
//     return _registerData.weight /
//         ((_registerData.height / 100) * (_registerData.height / 100));
//   }
//
//   // Calculate BMR
//   double calculateBMR() {
//     if (_registerData.weight <= 0 ||
//         _registerData.height <= 0 ||
//         _registerData.gender.isEmpty) {
//       return 0.0; // Return 0 instead of throwing exception
//     }
//
//     final age = DateTime.now().year - _registerData.dateOfBirth.year;
//
//     if (_registerData.gender == 'Male') {
//       return 88.362 +
//           (13.397 * _registerData.weight) +
//           (4.799 * _registerData.height) -
//           (5.677 * age);
//     } else {
//       return 447.593 +
//           (9.247 * _registerData.weight) +
//           (3.098 * _registerData.height) -
//           (4.330 * age);
//     }
//   }
// }
