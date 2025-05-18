import 'package:bloc/bloc.dart';
import 'package:fitfork_gp/features/Profile/data/logout_data_model.dart';
import 'package:fitfork_gp/features/Profile/data/update_profile_model.dart';
import 'package:fitfork_gp/features/Profile/data/user_data_model.dart';
import 'package:fitfork_gp/features/Profile/presentation/cubit/states.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:fitfork_gp/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generative_ai_dart/generative_ai_dart.dart';

import '../../../../constants.dart';
import '../../../../shared/cubit/appCubitStates.dart';
import '../../../../shared/network/local/cache_helper.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  GetUserData? getUserData;

  void GetAllUserData() async {

    emit(ProfileLoadingState());

    user_id = CacheHelper.getData(key: 'user_id');
    if (user_id == null) {
      emit(ProfileErrorState('User ID is null'));
      return;
    }

    DioHelper.getData2(
        url: 'user/$user_id'
    ).then((value) {

      getUserData = GetUserData.fromJson(value?.data);
      print('Parsed User ID: ${getUserData?.userId}');
      print('Parsed User Name: ${getUserData?.name}');


      emit(ProfileSuccessState(getUserData!));

    }).catchError((error) {
      print(error.toString());
      emit(ProfileErrorState(error.toString()));
    });
  }

  LogoutModel? logoutModel;

  void LogOut() {

    emit(ProfileLoadingState());

    user_id = CacheHelper.getData(key: 'user_id');
    if (user_id == null) {
      emit(ProfileErrorState('User ID is null'));
      return;
    }

    DioHelper.postData_logout(
        url: 'logout/$user_id',
    ).then((value) {

      logoutModel = LogoutModel.fromJson(value?.data);
      print('Status : ${logoutModel?.message}');

      CacheHelper.removeData(key: 'user_id');

      emit(ProfileLogoutSuccessState(logoutModel!));

    }).catchError((error) {
      print(error.toString());
      emit(ProfileLogoutErrorState(error.toString()));
    });

  }

  UpdateProfileModel? updateProfileModel;

  void updateProfileData({
    required BuildContext context,
    required Map<String, dynamic> updatedData,
  })
  {
    emit(ProfileUpdateLoadingState());

    user_id = CacheHelper.getData(key: 'user_id');
    if (user_id == null) {
      emit(ProfileErrorState('User ID is null'));
      return;
    }

    DioHelper.putData2(
        url: 'user/update_profile/$user_id',
        data: updatedData,
    ).then((value) {

      updateProfileModel = UpdateProfileModel.fromJson(value?.data);

      print('Updated Data: ${updateProfileModel?.message}');

      AppCubit.get(context).GetAllUserData();

      GetAllUserData();

      getUserData = GetUserData.fromJson(value?.data);

      emit(ProfileUpdateSuccessState(getUserData!));

    }).catchError((error){
      emit(ProfileUpdateErrorState(error.toString()));
    });

  }


}