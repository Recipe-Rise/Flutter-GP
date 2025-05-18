import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(Icons.chevron_left, color: Colors.black87),
                  SizedBox(width: 4),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.black54),
                onPressed: () {
                  // Handle edit button press
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black54),
                onPressed: () {
                  // Handle menu button press
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}