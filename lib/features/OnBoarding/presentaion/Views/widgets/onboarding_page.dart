import 'package:fitfork_gp/features/OnBoarding/data/models/onboarding_item.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  OnboardingPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image with reduced height
        Image.asset(
          item.imagePath,
          width: MediaQuery.of(context).size.width, // Full width
          height:
              MediaQuery.of(context).size.height * 0.6, // 60% of screen height
          fit: BoxFit.cover, // Ensures the image covers the area
        ),
        // Text below the image
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                item.descreption,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
