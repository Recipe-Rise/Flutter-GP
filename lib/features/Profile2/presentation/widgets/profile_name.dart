import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final String name;

  const ProfileName({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A2138),
      ),
    );
  }
}
