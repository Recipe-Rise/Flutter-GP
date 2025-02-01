import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'features/splash/presentaion/views/splash_view.dart';

void main() {
  runApp(const FitFork());
}

class FitFork extends StatelessWidget {
  const FitFork({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.white),
        home: const SplashView(),
      ),
    );
  }
}
