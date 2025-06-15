import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/features/Home/presentation/views/home_screen.dart'; // Import HomeScreen

class SuccessScreen extends StatelessWidget {
  final String firstName;

  const SuccessScreen({
    super.key,
    required this.firstName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                AssetsData.sucess,
                width: MediaQuery.of(context).size.width * 0.83,
                height: MediaQuery.of(context).size.height * 0.43,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              "Welcome, $firstName",
              style: Styles.textStyle26.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            Opacity(
              opacity: 0.7,
              child: Text(
                'You are all set now, let\'s reach\nyour goals together with us',
                style: Styles.textStyle14,
              ),
            ),
            const SizedBox(height: 140),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomGradientButton(
                text: 'Go To Home',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        firstName: firstName,
                      ),
                    ),
                  );
                },
                gradient: kButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
