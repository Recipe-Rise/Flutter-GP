import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Home/presentation/views/home_screen.dart';
import 'package:fitfork_gp/features/Login/presentation/cubit/login_cubit.dart';
import 'package:fitfork_gp/features/Login/presentation/widgets/social_login_buttons.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen1.dart';
import 'package:fitfork_gp/features/Register/presentation/views/success_screen.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_text_feild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../shared/network/local/cache_helper.dart';
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
      create: (context) => LoginCubit(), // Provide constructor parameters if needed
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
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {

          print(state.loginModel.message);

          CacheHelper.saveData(key: 'user_id', value: state.loginModel.userId).then((value){
            user_id = state.loginModel.userId;

            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder : (context)=> HomeScreen(
                      // firstName: state.loginModel.name,
                      )),
                      (Route<dynamic> route) => false);

            });
          });

          Fluttertoast.showToast(
              msg: state.loginModel.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SuccessScreen(
          //       firstName: firstName,
          //       bmi: bmi,
          //       bmr: bmr,
          //     ),
          //   ),
          // );

        } else if (state is LoginFailure) {
          Fluttertoast.showToast(
              msg: "Invalid E-mail or Password",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

        }
      },
      builder: (context , state) {
        return SingleChildScrollView(
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
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: LoginCubit.get(context).isPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          LoginCubit.get(context).changePassVisibility();
                        },
                        icon: Icon(LoginCubit.get(context).suffix),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {
                        LoginCubit.get(context).login(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context
                        );
                      }
                    },

                  ),

                  // CustomTextFeild(
                  //   label: "Password",
                  //   controller: passwordController,
                  //   keyboardType: TextInputType.visiblePassword,
                  //   obscureText: LoginCubit.get(context).isPassword,
                  //   icon: Icons.lock,
                  //   onChanged: (value) {},
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your password';
                  //     }
                  //     if (value.length < 6) {
                  //       return 'Password must be at least 6 characters';
                  //     }
                  //     return null;
                  //   },
                  //
                  // ),

                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'Forgot your password?',
                          style: Styles.textStyle16.copyWith(
                            //color: Colors.black,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            //decorationColor: Colors.black,
                            decorationThickness: 2,
                            height: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      final isLoading = state is LoginLoading;
                      return CustomGradientButton(
                        text: isLoading ? 'Loading...' : 'Login',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Call the login method from the LoginCubit
                            LoginCubit.get(context).login(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                            // context.read<LoginCubit>().login(
                            //       email : emailController.text,
                            //       password : passwordController.text,
                            //     );
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
                            //color: Colors.black,
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
                      style: TextStyle(
                        color : Theme.of(context).brightness == Brightness.dark ?
                        Colors.white :
                        Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
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
        );
      },
    );
  }
}
