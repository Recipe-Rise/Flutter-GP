import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/features/Profile/presentation/cubit/cubit.dart';
import 'package:fitfork_gp/features/Profile/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;

  const EditProfileScreen({
    Key? key,
    required this.profileData,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late Map<String, dynamic> updatedData;

  late TextEditingController _nameController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _fitnessGoalController;
  late TextEditingController _activityLevelController;
  String? _selectedGender;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profileData['name'] ?? '');
    _emailController = TextEditingController(text: widget.profileData['email'] ?? '');
    _weightController = TextEditingController(text: widget.profileData['weight']?.toString());
    _heightController = TextEditingController(text: widget.profileData['height']?.toString());
    _ageController = TextEditingController(text: widget.profileData['age']?.toString());
    _fitnessGoalController = TextEditingController(text: widget.profileData['fitness_goal']);
    _activityLevelController = TextEditingController(text: widget.profileData['activity_level']);
    _selectedGender = widget.profileData['gender'];
  }
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    _fitnessGoalController.dispose();
    _activityLevelController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'age': int.tryParse(_ageController.text.trim()), // Ensure age is an integer
      'weight': int.tryParse(_weightController.text.trim()), // Ensure weight is an integer
      'height': int.tryParse(_heightController.text.trim()), // Ensure height is an integer
      'fitness_goal': _fitnessGoalController.text.trim(),
      'gender': _selectedGender ?? '',
      'activity_level': _activityLevelController.text.trim(), // Add activity level
      };

      ProfileCubit.get(context).updateProfileData(
          context: context ,
          updatedData: updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit , ProfileStates>(
      listener: (context , state){
        if (state is ProfileUpdateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
          Navigator.pop(context);
        } else if (state is ProfileUpdateErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update profile: ${state.error}')),
          );
        }
      },
      builder: (context , state ){
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueAccent,
                  Color(0xFFF2F2F2),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle:
                                const TextStyle(color: Colors.blueAccent),
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.blueAccent),
                                prefixIcon: const Icon(Icons.email, color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              value: _selectedGender,
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                labelStyle:
                                const TextStyle(color: Colors.blueAccent),
                                prefixIcon:
                                const Icon(Icons.wc, color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              items: ['male', 'female']
                                  .map((gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _ageController,
                              decoration: InputDecoration(
                                labelText: 'Age (years)',
                                labelStyle:
                                const TextStyle(color: Colors.blueAccent),
                                prefixIcon: const Icon(Icons.cake,
                                    color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age';
                                }
                                int? age = int.tryParse(value);
                                if (age == null || age <= 0 || age > 120) {
                                  return 'Please enter a valid age (1-120)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                labelText: 'Weight (kg)',
                                labelStyle:
                                const TextStyle(color: Colors.blueAccent),
                                prefixIcon: const Icon(Icons.fitness_center,
                                    color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your weight';
                                }
                                double? weight = double.tryParse(value);
                                if (weight == null || weight <= 0 || weight > 300) {
                                  return 'Please enter a valid weight (1-300 kg)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _heightController,
                              decoration: InputDecoration(
                                labelText: 'Height (cm)',
                                labelStyle:
                                const TextStyle(color: Colors.blueAccent),
                                prefixIcon: const Icon(Icons.height,
                                    color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your height';
                                }
                                double? height = double.tryParse(value);
                                if (height == null || height <= 0 || height > 300) {
                                  return 'Please enter a valid height (1-300 cm)';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _fitnessGoalController,
                              decoration: InputDecoration(
                                labelText: 'Fitness Goal',
                                labelStyle: const TextStyle(color: Colors.blueAccent),
                                prefixIcon: const Icon(Icons.flag, color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your fitness goal';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _activityLevelController,
                              decoration: InputDecoration(
                                labelText: 'Activity Level',
                                labelStyle: const TextStyle(color: Colors.blueAccent),
                                prefixIcon: const Icon(Icons.directions_run, color: Colors.blueAccent),
                                filled: true,
                                fillColor: Colors.grey[100],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your activity level';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            CustomGradientButton(
                              text: 'Save',
                              onPressed: _saveProfile,
                              gradient: kButtonColor,
                              //  const LinearGradient(
                              //   colors: [Colors.blue, Colors.blueAccent],
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              // ),
                              width: double.infinity,
                              height: 54,
                              borderRadius: 12,
                              icon: Icons.save,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Gradient gradient;
  final double width;
  final double height;
  final double borderRadius;
  final IconData? icon;

  const CustomGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.gradient,
    this.width = 280,
    this.height = 60,
    this.borderRadius = 32,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(icon, color: Colors.white),
                  ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: onPressed != null
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
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