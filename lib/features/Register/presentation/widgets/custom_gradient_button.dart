import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;
  final double width;
  final double height;
  final double borderRadius;

  const CustomGradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.width = 280,
    this.height = 60,
    this.borderRadius = 32,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
