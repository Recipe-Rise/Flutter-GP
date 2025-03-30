import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': FontAwesomeIcons.user, 'title': 'Profile'},
      {'icon': FontAwesomeIcons.star, 'title': 'Favorite'},
      {'icon': FontAwesomeIcons.rightFromBracket, 'title': 'Logout'},
    ];
    return Column(
      children: List.generate(
        menuItems.length * 2 - 1,
        (index) {
          if (index.isEven) {
            final itemIndex = index ~/ 2;
            return ProfileMenuItem(
              icon: menuItems[itemIndex]['icon'] as IconData,
              title: menuItems[itemIndex]['title'] as String,
              onTap: () {
                // Handle menu item taps
                if (menuItems[itemIndex]['title'] == 'Logout') {
                  // Handle logout
                }
              },
            );
          } else {
            return SizedBox(height: 40); // Space between items
          }
        },
      ),
    );
  }
}
