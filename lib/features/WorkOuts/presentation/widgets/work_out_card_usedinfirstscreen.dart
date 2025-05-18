import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class WorkoutCard extends StatelessWidget {
  final String title;
  final int exercises;
  final int duration;
  final String imagePath;
  final Widget targetScreen;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.exercises,
    required this.duration,
    required this.imagePath,
    required this.targetScreen,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.16,
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FE),
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Text(
                    '$exercises Exercises | ${duration}mins',
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => targetScreen,
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.025,
                        vertical: size.height * 0.010,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(size.width * 0.04),
                      ),
                      child: Text('View More',
                          style: Styles.textStyle14
                              .copyWith(color: Colors.blue)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size.width * 0.12),
              ),
              margin: EdgeInsets.all(size.width * 0.03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.width * 0.12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
