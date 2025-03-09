import 'package:fitfork_gp/features/OnBoarding/presentaion/Views/on_Boarding_view.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:fitfork_gp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'features/splash/presentaion/views/splash_view.dart';
import 'package:fitfork_gp/shared/bloc_observer.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:fitfork_gp/shared/cubit/appCubitStates.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer =  MyBlocObserver();
  await CacheHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');


  if(onBoarding != null){
    widget = RegisterScreen1();
  }
  else {
    widget = OnboardingScreen();
  }
  runApp(FitFork(startWidget : widget));
}


class FitFork extends StatelessWidget {

  final Widget startWidget;
  FitFork({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit(),),
        BlocProvider(create: (BuildContext context) => RegisterCubit(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context,state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.white),
            home : startWidget,
          );
        },
      ),
    );
  }
}
