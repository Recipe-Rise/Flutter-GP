import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // Make this nullable
  final Gradient gradient;
  final double width;
  final double height;
  final double borderRadius;
  final IconData? icon;

  const CustomGradientButton({
    super.key,
    required this.text,
    this.onPressed, // No longer required
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
                    // color: Colors.white,
                    // Make text slightly transparent when disabled
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
