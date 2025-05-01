import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';

class SleepCard extends StatelessWidget {
  final String hours;
  final String minutes;
  final VoidCallback onTap;

  const SleepCard({
    super.key,
    required this.hours,
    required this.minutes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sleep",
                style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "${hours}h ",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF96B2FE),
                      ),
                    ),
                    TextSpan(
                      text: "${minutes}m",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF96B2FE),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                AssetsData.sleep,
                height: 90,
                width: 350,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
