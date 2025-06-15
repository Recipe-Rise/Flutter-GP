import 'package:fitfork_gp/features/Register/presentation/views/register_screen31.dart';
import 'package:fitfork_gp/features/Register/presentation/views/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../constants.dart';
import '../../../../core/utils/assets.dart';
import '../cubit/cubit/register_cubit.dart';
import '../cubit/cubit/register_state.dart';
import '../widgets/custom_gradient_button.dart';
import '../widgets/custom_text_feild.dart';

class RegisterScreen2 extends StatefulWidget {
  const RegisterScreen2({super.key});

  @override
  State<RegisterScreen2> createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? _selectedGender;
  DateTime _selectedDate = DateTime.now();
  late int _calcAge;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context,state) {
        if (state is RegisterSuccessState) {
          Fluttertoast.showToast(
            msg: "User added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        } else if (state is RegisterErrorState) {
          Fluttertoast.showToast(
            msg: "Error: ${state.error}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      },
      builder: (context , state ){
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    AssetsData.reg2,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 12),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Gender",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading:
                                  const Icon(Icons.male, color: Colors.blue),
                                  title: const Text('Male'),
                                  trailing: Radio<String>(
                                    value: 'Male',
                                    groupValue: _selectedGender,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading:
                                  const Icon(Icons.female, color: Colors.pink),
                                  title: const Text('Female'),
                                  trailing: Radio<String>(
                                    value: 'Female',
                                    groupValue: _selectedGender,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date of Birth",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _selectedDate = pickedDate;

                                  final DateTime today = DateTime.now();
                                  int age = today.year - pickedDate.year;
                                  if (today.month < pickedDate.month ||
                                      (today.month == pickedDate.month && today.day < pickedDate.day)) {
                                    age--;
                                  }
                                  print('Calculated Age: $age');
                                  _calcAge = age;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${_selectedDate.toLocal()}".split(' ')[0],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFeild(
                    label: 'Weight (kg)',
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                    icon: Icons.fitness_center,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFeild(
                    label: 'Height (cm)',
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }
                      return null;
                    },
                    icon: Icons.straighten,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: CustomGradientButton(
                      text: 'Next',
                      onPressed: () {
                        if (_selectedGender == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your gender'),
                            ),
                          );
                          return;
                        }

                        if (_weightController.text.isEmpty ||
                            _heightController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter your weight and height'),
                            ),
                          );
                          return;
                        }

                        if (_calcAge == null || _calcAge <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a valid date of birth'),
                            ),
                          );
                          return;
                        }

                        final cubit = context.read<RegisterCubit>();

                        cubit.updateGender(_selectedGender!);
                        cubit.updateDateOfBirth(_selectedDate);
                        cubit.updateWeight(double.parse(_weightController.text));
                        cubit.updateHeight(double.parse(_heightController.text));

                        RegisterCubit.get(context).registerUser(
                            name: cubit.registerData.firstName,
                            email: cubit.registerData.email,
                            password: cubit.registerData.password,
                            age: _calcAge,
                            gender: RegisterCubit.get(context).registerData.gender,
                            weight: RegisterCubit.get(context).registerData.weight,
                            height: RegisterCubit.get(context).registerData.height,
                            activityLevel: RegisterCubit.get(context).registerData.activityLevel,
                            fitnessGoal: RegisterCubit.get(context).registerData.fitnessGoal,
                            context: context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessScreen(
                                firstName: RegisterCubit.get(context).registerData.firstName,
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
          ),
        );
      },
    );
  }
}
