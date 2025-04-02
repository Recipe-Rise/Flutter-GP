import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const NavButton({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          disabledBackgroundColor: Colors.blue.withOpacity(0.5),
          disabledForegroundColor: Colors.white.withOpacity(0.7),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
