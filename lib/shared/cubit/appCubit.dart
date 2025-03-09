import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appCubitStates.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void ChangeAppMode()
  {
    isDark = !isDark;
    emit(AppChangeModeState());

  }

}