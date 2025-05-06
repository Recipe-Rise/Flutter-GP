import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/features/Profile2/presentation/views/edit_profile_screen.dart';
import 'package:fitfork_gp/features/Profile2/presentation/widgets/basal_mtabolic_rate_card.dart';
import 'package:fitfork_gp/features/Profile2/presentation/widgets/profile_app_bar.dart';
import 'package:fitfork_gp/features/Profile2/presentation/widgets/profile_avatar.dart';
import 'package:fitfork_gp/features/Profile2/presentation/widgets/profile_info_card.dart';
import 'package:fitfork_gp/features/Profile2/presentation/widgets/profile_name.dart';
import 'package:fitfork_gp/features/Profile2/presentation/widgets/quick_actions_section.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen2 extends StatefulWidget {
  const ProfileScreen2({Key? key}) : super(key: key);

  @override
  _ProfileScreen2State createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2> {
  Map<String, dynamic> profileData = {
    'name': 'Mariam Essam',
    'age': 22,
    'weight': 64.0,
    'height': 156.0,
    'bmi': 26.0,
    'bmr': 1500.0,
    'gender': 'female',
  };

  void _updateProfile(Map<String, dynamic> updatedData) {
    setState(() {
      profileData = updatedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ProfileAvatar(gender: profileData['gender'] ?? 'female'),
                      const SizedBox(height: 16),
                      ProfileName(name: profileData['name'] ?? 'Mariam Essam'),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ProfileInfoCard(
                              title: 'Age',
                              value: '${profileData['age'] ?? 22} years',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ProfileInfoCard(
                              title: 'Weight',
                              value: '${profileData['weight'] ?? 64.0} kg',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ProfileInfoCard(
                              title: 'Height',
                              value: '${profileData['height'] ?? 156.0} cm',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ProfileInfoCard(
                              title: 'BMI',
                              value:
                                  (profileData['bmi'] ?? 26).toStringAsFixed(1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      BasalMetabolicRateCard(
                        value:
                            '${(profileData['bmr'] ?? 1500.0).toStringAsFixed(0)} kcal/day',
                        description:
                            'The amount of energy you need while resting',
                      ),
                      const SizedBox(height: 16),
                      const QuickActionsSection(),
                      const SizedBox(height: 24),
                      CustomGradientButton(
                        text: 'Edit Profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                profileData: profileData,
                                onSave: _updateProfile,
                              ),
                            ),
                          );
                        },
                        gradient: kButtonColor,
                        width: double.infinity,
                        height: 60,
                        borderRadius: 32,
                        icon: Icons.edit_outlined,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        selectedItemColor: const Color(0xFF4da0ff),
        unselectedItemColor: Colors.grey,
        currentIndex: 4, // Profile tab is index 4
        onTap: (index) {
          if (index != 4) {
            AppNavigator.navigateToTabScreen(context, index);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.dumbbell),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.message),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.utensils),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Profile',
          ),
        ],
      ),
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
