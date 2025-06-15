import 'package:fitfork_gp/features/Login/presentation/views/login_screen.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen2.dart';
import 'package:fitfork_gp/features/Register/presentation/views/verification_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/cubit/register_cubit.dart';
import '../cubit/cubit/register_state.dart';
import '../widgets/custom_gradient_button.dart';
import '../widgets/custom_text_feild.dart';

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
  bool _acceptTerms = false;

  void _verifyEmail(BuildContext context) {
    if (_formKey.currentState!.validate() && _acceptTerms) {
      RegisterCubit.get(context).updateFirstName(_firstNameController.text);
      RegisterCubit.get(context).updateLastName(_lastNameController.text);
      RegisterCubit.get(context).updateEmail(_emailController.text);

      RegisterCubit.get(context).sendEmailVerificationCode(
        email: _emailController.text,
      );

    } else if (!_acceptTerms) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the terms and conditions'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context , state){
        if (state is VerificationCodeSuccessState) {

          if(!mounted) return ;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VerificationCodeScreen(
                    email: _emailController.text,
                  ),
                ),
              );
            });
        }
        else if (state is VerificationCodeErrorState) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.error}'),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            shadowColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Hey there,',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  // CustomTextFeild(
                  //   label: 'Password',
                  //   controller: _passwordController,
                  //   obscureText: true,
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
                  //   icon: Icons.lock,
                  // ),
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
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: CustomGradientButton(
                      text: 'Verify Email',
                      onPressed: () {
                        _verifyEmail(context);
                      },
                      gradient: kButtonColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        color: kPrimaryColor,
                      ),
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

