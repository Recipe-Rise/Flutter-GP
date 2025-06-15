import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/features/Home/presentation/cubit/home_cubit.dart';
import 'package:fitfork_gp/features/Home/presentation/views/home_screen.dart';
import 'package:fitfork_gp/features/Login/presentation/cubit/login_cubit.dart';
import 'package:fitfork_gp/features/Login/presentation/views/login_screen.dart';
import 'package:fitfork_gp/features/OnBoarding/presentaion/Views/on_Boarding_view.dart';
import 'package:fitfork_gp/features/Profile/presentation/cubit/cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:fitfork_gp/features/WorkOuts/presentation/cubit/cubit.dart';
import 'package:fitfork_gp/features/onbparding2/presentation/cubits/onboarding_cubit.dart';
import 'package:fitfork_gp/shared/network/local/cache_helper.dart';
import 'package:fitfork_gp/shared/network/remote/dio_helper.dart';
import 'package:flutter/gestures.dart';
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
  DioHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  //user_id = CacheHelper.getData(key: 'user_id');

  //print(user_id);

  if(onBoarding != null){
    // if(user_id != null){
    //   widget = HomeScreen(
    //       firstName: '',
    //       bmi: 20,
    //       bmr: 20,);
    // }
    widget = LoginScreen();
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
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit(),),
        BlocProvider(create: (BuildContext context) => WorkOutCubit(),),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => ProfileCubit()),
        BlocProvider(create: (BuildContext context) => RecipeRecommendationCubit()),
        BlocProvider(create: (BuildContext context) => HomeCubit()),
        BlocProvider(create: (BuildContext context) => OnboardingCubit()),


      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context,state) {
          // if(startWidget is HomeScreen){
          //   return GetMaterialApp(
          //     debugShowCheckedModeBanner: false,
          //     theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.white),
          //     home : HomeScreen(
          //         firstName: LoginCubit.get(context).loginModel?.name ?? 'Guest',
          //         bmi: 20,
          //         bmr: 20
          //     ),
          //   );
          // }
          return GetMaterialApp(


            debugShowCheckedModeBanner: false,
            //theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.white),
            themeMode: ThemeMode.system,
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2A72B4) , brightness: Brightness.dark),
              useMaterial3: true,
            ),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff2A72B4) , brightness: Brightness.light),
              useMaterial3: true,
            ),
            home : startWidget,
          );
        },
      ),
    );
  }
}
