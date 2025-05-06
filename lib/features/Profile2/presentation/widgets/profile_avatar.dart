import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String gender;

  const ProfileAvatar({
    Key? key,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Select image URL based on gender
    final String imageUrl = gender.toLowerCase() == 'male'
        ? 'https://avatar.iran.liara.run/public/boy' // Example URL for male avatar
        : 'https://avatar.iran.liara.run/public/girl'; // Example URL for female avatar

    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: Center(
          child: Image.network(
            imageUrl,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Text(
                    '400\nx\n400',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
