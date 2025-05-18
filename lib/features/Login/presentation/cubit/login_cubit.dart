import 'package:fitfork_gp/features/Login/data/models/login_model.dart';
import 'package:fitfork_gp/features/Login/presentation/cubit/states.dart';
import 'package:fitfork_gp/features/Profile/presentation/cubit/cubit.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:fitfork_gp/shared/network/end_points.dart';
import 'package:fitfork_gp/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../shared/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  Future<void> login({
  required String email,
  required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());

    DioHelper.postData2(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
        }
    ).then((value) {
      print(value?.data);
      loginModel = LoginModel.fromJson(value?.data);

      print('Parsed User ID: ${loginModel?.userId}');
      print('Parsed User Name: ${loginModel?.name}');

      CacheHelper.saveData(key: 'user_id', value: loginModel?.userId);

      user_id = CacheHelper.getData(key: 'user_id');
      if (user_id != null) {
        print('Logged-in User ID: $user_id');
        AppCubit.get(context).GetAllUserData();
      }

      emit(LoginSuccess(loginModel!));

    }).catchError((error) {
      print(error.toString());
      emit(LoginFailure(error.toString()));
    }); // Emit loading state

  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePasswordVisibilityState());
  }
}

