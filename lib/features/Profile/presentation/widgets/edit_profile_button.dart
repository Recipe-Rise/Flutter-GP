import 'package:fitfork_gp/features/Profile/presentation/views/edit_profile_screen.dart';
import 'package:flutter/material.dart';

import '../views/edit_profile_screen.dart';

class EditProfileButton extends StatelessWidget {
  final Map<String, dynamic> profileData;
  final Function(Map<String, dynamic>) onSave;

  const EditProfileButton({
    Key? key,
    required this.profileData,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditProfileScreen(
                profileData: profileData,
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.edit_outlined,
          color: Colors.white,
        ),
        label: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}