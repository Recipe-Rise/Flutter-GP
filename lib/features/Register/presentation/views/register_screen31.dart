import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen32.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen31 extends StatelessWidget {
  const RegisterScreen31({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit , RegisterState>(
      listener: (context , state) {},
      builder: (context , state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'What is your goal?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'It will help us to choose a best\nprogram for you',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      AssetsData.reg31,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                CustomGradientButton(
                  text: 'Confirm',
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const RegisterScreen32(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  gradient: kButtonColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
