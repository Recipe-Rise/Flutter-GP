import 'package:fitfork_gp/features/Register/presentation/views/register_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/cubit/register_cubit.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context , state){},
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
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: CustomGradientButton(
                      text: 'Register',
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
                              content:
                              Text('Please accept the terms and conditions'),
                            ),
                          );
                        }
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
                          builder: (context) => RegisterScreen2(),
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
