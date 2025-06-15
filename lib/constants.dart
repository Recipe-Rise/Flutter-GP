import 'package:fitfork_gp/features/Login/presentation/views/login_screen.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:fitfork_gp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

const kTranstionDuration = Duration(milliseconds: 250);
const kPrimaryColor = Color(0xff5CB1FF);

const LinearGradient kButtonColor = LinearGradient(
  colors: [
    Color(0xFF5CB1FF),
    Color(0xFF11304F),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

void signOut(context){

  CacheHelper.removeData(key: 'user_id').then((value){
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=> LoginScreen()),
            (Route<dynamic> route) => false);
  });
}

var user_id;

var remainingCalories;

var consumedCalories;

AppCubit appCubit = AppCubit();

