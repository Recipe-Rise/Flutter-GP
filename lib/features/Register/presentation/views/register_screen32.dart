import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen33.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen32 extends StatelessWidget {
  const RegisterScreen32({super.key});

  @override
  Widget build(BuildContext context) {
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
                  AssetsData.reg32,
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
                        const RegisterScreen33(),
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
  }
}
