import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';

import '../../../Register/presentation/views/register_screen1.dart';

class ActivityLevelScreen extends StatefulWidget {
  const ActivityLevelScreen({Key? key}) : super(key: key);

  @override
  State<ActivityLevelScreen> createState() => _ActivityLevelScreenState();
}

class _ActivityLevelScreenState extends State<ActivityLevelScreen> {
  String selectedActivityLevel = '';

  final List<Map<String, String>> activityLevels = [
    {
      'title': 'Sedentary',
      'description': 'Spend most of the day sitting (e.g., bank teller, desk job).',
    },
    {
      'title': 'Lightly Active',
      'description': 'Spend a good part of the day on your feet (e.g., teacher, salesperson).',
    },
    {
      'title': 'Moderate',
      'description': 'Spend a good part of the day doing some physical activity (e.g., food server, postal carrier).',
    },
    {
      'title': 'Very Active',
      'description': 'Spend a good part of the day doing heavy physical activity (e.g., bike messenger, carpenter).',
    },
    {
      'title': 'Extra Active',
      'description': 'Spend most of the day doing very heavy physical activity (e.g., construction worker, athlete).',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity Level',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            const Text(
              "What is your baseline activity level?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Not including workouts - we count that separately.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Choose what describes you best:",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: activityLevels.length,
                itemBuilder: (context, index) {
                  final activity = activityLevels[index];
                  final isSelected = selectedActivityLevel == activity['title'];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedActivityLevel = activity['title']!;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? const Color(0xFF2575FC) : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected ? const Color(0xFF2575FC).withOpacity(0.1) : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF2575FC) : Colors.grey,
                                  width: 2,
                                ),
                                color: isSelected ? const Color(0xFF2575FC) : Colors.transparent,
                              ),
                              child: isSelected
                                  ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    activity['title']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? const Color(0xFF2575FC) : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    activity['description']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: screenWidth * 0.85,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6A11CB).withOpacity(selectedActivityLevel.isNotEmpty ? 1.0 : 0.5),
                      const Color(0xFF2575FC).withOpacity(selectedActivityLevel.isNotEmpty ? 1.0 : 0.5),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: selectedActivityLevel.isNotEmpty
                      ? () {
                    RegisterCubit.get(context).updateActivityLevel(selectedActivityLevel);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen1(),
                      ),
                    );
                    print('Selected activity level: $selectedActivityLevel');
                    // Navigate to next screen or perform action
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}