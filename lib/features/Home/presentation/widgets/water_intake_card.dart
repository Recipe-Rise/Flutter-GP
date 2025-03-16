import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:flutter/material.dart';

class WaterIntakeCard extends StatelessWidget {
  final int waterIntakeInML;
  final List<Map<String, dynamic>> timeUpdates;
  const WaterIntakeCard(
      {super.key, required this.waterIntakeInML, required this.timeUpdates});

  @override
  Widget build(BuildContext context) {
    final waterInLiters = (waterIntakeInML / 1000).toStringAsFixed(1);

    return Container(
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
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Align to top
          children: [
            Container(
              height: 400,
              width: 20,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: 16,
                        height: (waterIntakeInML / 4000) * 290,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF5DCCFF), Color(0xFF1A75FF)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  )
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Water Intake",
                    style: Styles.textStyle18
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "$waterInLiters Liters",
                    style: Styles.textStyle22.copyWith(
                      color: const Color(0xff6ABBFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Real time updates",
                    style: Styles.textStyle16.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ...timeUpdates.map((update) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF1C3EF),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  update['time'],
                                  style: Styles.textStyle14.copyWith(
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "${update['amount']}ml",
                                  style: Styles.textStyle14.copyWith(
                                    color: const Color(0xFFD9C6FF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
