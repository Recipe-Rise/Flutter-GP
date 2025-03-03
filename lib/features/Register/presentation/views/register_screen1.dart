import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Login/presentation/widgets/social_login_buttons.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/cubit/register_cubit.dart';
import '../widgets/custom_gradient_button.dart';
import '../widgets/custom_text_feild.dart';
import 'package:fitfork_gp/features/Login/presentation/views/login_screen.dart'; // Import the LoginScreen

class RegisterScreen1 extends StatefulWidget {
  RegisterScreen1({super.key});

  @override
  _RegisterScreen1State createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   elevation: 0,
      //   shadowColor: Colors.white,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text('Hey there,', style: Styles.textStyle18),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text('Create an Account', style: Styles.textStyle30),
                  ),
                  const SizedBox(height: 32),
                  CustomTextFeild(
                    label: 'First Name',
                    controller: _firstNameController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 32),
                  CustomTextFeild(
                    label: 'Last Name',
                    controller: _lastNameController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 32),
                  CustomTextFeild(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
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
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 32),
                  CustomTextFeild(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: true,
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
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'By continuing, you accept our Privacy Policy and Terms of Use',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: CustomGradientButton(
                      text: 'Next',
                      onPressed: () {
                        if (_formKey.currentState!.validate() && _acceptTerms) {
                          final cubit = context.read<RegisterCubit>();
                          cubit.updateFirstName(_firstNameController.text);
                          cubit.updateLastName(_lastNameController.text);
                          cubit.updateEmail(_emailController.text);
                          cubit.updatePassword(_passwordController.text);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen2(),
                            ),
                          );
                        } else if (!_acceptTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please accept the terms and conditions'),
                            ),
                          );
                        }
                      },
                      gradient: kButtonColor,
                    ),
                  ),
                  const SizedBox(height: 32),
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
                  const SizedBox(height: 24),
                  const SocialLoginButtons(),
                  const SizedBox(height: 32),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: Styles.textStyle16.copyWith(
                        color: Colors.black.withOpacity(0.8),
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
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
      ),
    );
  }
}
