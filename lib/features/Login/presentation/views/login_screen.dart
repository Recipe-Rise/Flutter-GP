import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Login/presentation/cubit/login_cubit.dart';
import 'package:fitfork_gp/features/Login/presentation/widgets/social_login_buttons.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:fitfork_gp/features/Register/presentation/views/success_screen.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_text_feild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/states.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the LoginCubit directly in this widget
    return BlocProvider(
      create: (context) =>
          LoginCubit(), // Provide constructor parameters if needed
      child: Scaffold(
        body: SafeArea(
          child: _LoginForm(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ),
      ),
    );
  }
}

// Extract the form into a separate stateless widget to use the BlocProvider
class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          final firstName = "Mariam";
          final bmi = 22.5;
          final bmr = 1800.0;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessScreen(
                firstName: firstName,
                bmi: bmi,
                bmr: bmr,
              ),
            ),
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text('Hey there,', style: Styles.textStyle18),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text('Welcome Back', style: Styles.textStyle26),
                ),
                const SizedBox(height: 32),
                CustomTextFeild(
                  label: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                CustomTextFeild(
                  label: "Password",
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  icon: Icons.lock,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        'Forgot your password?',
                        style: Styles.textStyle16.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                          decorationThickness: 2,
                          height: 3,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    final isLoading = state is LoginLoading;
                    return CustomGradientButton(
                      text: isLoading ? 'Loading...' : 'Login',
                      onPressed: () {
                        if (!isLoading && formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                                emailController.text,
                                passwordController.text,
                              );
                        }
                      },
                      gradient: kButtonColor,
                    );
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Or',
                        style: Styles.textStyle14.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const SocialLoginButtons(),
                const SizedBox(height: 60),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Don\'t have an account yet? ',
                    style: Styles.textStyle16.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen1(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
