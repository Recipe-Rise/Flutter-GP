import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Register/data/Models/register_data.dart';
import 'package:fitfork_gp/features/Register/presentation/widgets/custom_gradient_button.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final RegisterData userData;

  const ProfileHeader({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.09,
            backgroundColor: Colors.blue.shade100,
            child: Text(
              _getInitials(userData),
              style: Styles.textStyle30.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06,
              ),
            ),
          ),

          SizedBox(width: screenWidth * 0.04),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${userData.firstName} ${userData.lastName}",
                  style: Styles.textStyle22.copyWith(
                    fontSize: screenWidth * 0.05,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                SizedBox(height: 4),
                Text(
                  "${userData.goal} Program",
                  style: Styles.textStyle16.copyWith(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          // Edit Button
          CustomGradientButton(
            text: "Edit",
            onPressed: () {},
            gradient: kButtonColor,
            width: screenWidth * 0.22, // Responsive button width
          ),
        ],
      ),
    );
  }

  String _getInitials(RegisterData userData) {
    if (userData.firstName.isEmpty || userData.lastName.isEmpty) {
      return "U";
    }
    return "${userData.firstName[0]}${userData.lastName[0]}";
  }
}
