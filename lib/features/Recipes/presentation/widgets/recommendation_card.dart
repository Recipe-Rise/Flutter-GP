import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';

class RecommendationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBackgroundColor;
  final bool isSelected;
  final VoidCallback onTap;

  const RecommendationCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconBackgroundColor,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Styles.textStyle16.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
