import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/features/Profile/presentation/views/edit_profile_screen.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_state.dart';
import 'package:fitfork_gp/features/Register/presentation/views/register_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit/register_cubit.dart';

class PasswordInputScreen extends StatefulWidget {
  const PasswordInputScreen({Key? key}) : super(key: key);

  @override
  _PasswordInputScreenState createState() => _PasswordInputScreenState();
}

class _PasswordInputScreenState extends State<PasswordInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Set Password'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: RegisterCubit.get(context).isPassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          RegisterCubit.get(context).changePassVisibility();
                        },
                        icon: Icon(RegisterCubit.get(context).suffix),
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
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: RegisterCubit.get(context).isPassword,
                    decoration: InputDecoration(

                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                      onPressed: (){
                        RegisterCubit.get(context).changePassVisibility();
                      },
                      icon: Icon(RegisterCubit.get(context).suffix),

                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  CustomGradientButton(
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {

                        RegisterCubit.get(context).updatePassword(_passwordController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen2(), // Replace with the next screen
                          ),
                        );
                      }
                    },
                    text: 'Continue',
                    gradient: kButtonColor,
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