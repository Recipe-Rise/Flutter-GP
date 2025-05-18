import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/features/Profile/data/user_data_model.dart';
import 'package:fitfork_gp/shared/network/end_points.dart';
import 'package:fitfork_gp/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/Profile/data/user_data_model.dart';
import '../../features/Profile/data/user_data_model.dart';
import '../network/local/cache_helper.dart';
import 'appCubitStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void ChangeAppMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }


  GetUserData? getUserData;

  void GetAllUserData() async {

    emit(AppLoadingUserDataState());

    user_id = CacheHelper.getData(key: 'user_id');
    if (user_id == null) {
      emit(AppErrorUserDataState('User ID is null'));
      return;
    }

    DioHelper.getData2(
        url: 'user/$user_id'
    ).then((value) {

      getUserData = GetUserData.fromJson(value?.data);
      print('Parsed User ID: ${getUserData?.userId}');
      print('Parsed User Name: ${getUserData?.name}');


      emit(AppSuccessUserDataState(getUserData!));

    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUserDataState(error.toString()));
    });
  }
}