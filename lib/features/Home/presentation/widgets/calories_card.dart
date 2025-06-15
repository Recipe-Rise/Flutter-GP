// import 'package:flutter/material.dart';
// import 'package:fitfork_gp/core/utils/styles.dart';
//
// import '../../../../shared/network/local/cache_helper.dart';
//
// class CaloriesCard extends StatelessWidget {
//   final double bmr;
//   final double consumedCalories;
//   final VoidCallback onTap; // Add this callback for navigation
//
//   const CaloriesCard({
//     super.key,
//     required this.bmr,
//     required this.consumedCalories,
//     required this.onTap, // Require the callback in constructor
//   });
//
//   Future<double> _fetchRemainingCalories() async {
//     return await CacheHelper().getRemainingCalories(bmr);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//
//     final double remainingCalories = (bmr - consumedCalories);
//     final double completionPercentage = bmr > 0 ? (consumedCalories / bmr).clamp(0.0, 1.0) : 0.0;
//
//
//     final double cardPadding = screenSize.width * 0.05;
//     final double progressSize = screenSize.width * 0.28;
//     final double progressThickness = screenSize.width * 0.03;
//
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(24),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(cardPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Calories",
//                 style: Styles.textStyle18.copyWith(
//                   fontWeight: FontWeight.bold,
//                   fontSize: screenSize.width * 0.045,
//                 ),
//               ),
//               SizedBox(height: screenSize.height * 0.01),
//               Text(
//                 "${bmr.toInt()} kCal",
//                 style: TextStyle(
//                   fontSize: screenSize.width * 0.07,
//                   fontWeight: FontWeight.w500,
//                   color: const Color(0xFF96B2FE),
//                 ),
//               ),
//               SizedBox(height: screenSize.height * 0.02),
//               Center(
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     SizedBox(
//                       width: progressSize,
//                       height: progressSize,
//                       child: CircularProgressIndicator(
//                         value: completionPercentage,
//                         strokeWidth: progressThickness,
//                         backgroundColor: Colors.grey.shade200,
//                         valueColor:
//                         const AlwaysStoppedAnimation(Color(0xFF96B2FE)),
//                       ),
//                     ),
//                     Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "${remainingCalories.toInt()} kCal",
//                           style: TextStyle(
//                             fontSize: screenSize.width * 0.05,
//                             fontWeight: FontWeight.bold,
//                             color: const Color(0xFF96B2FE),
//                           ),
//                         ),
//                         Text(
//                           "left",
//                           style: TextStyle(
//                             fontSize: screenSize.width * 0.035,
//                             color: const Color(0xFF96B2FE),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:fitfork_gp/core/utils/styles.dart';
// import '../../../../shared/network/local/cache_helper.dart';
//
// class CaloriesCard extends StatelessWidget {
//   final double bmr;
//   final double consumedCalories; // still required for fallback
//   final VoidCallback onTap;
//
//   const CaloriesCard({
//     super.key,
//     required this.bmr,
//     required this.consumedCalories,
//     required this.onTap,
//   });
//
//   Future<double> _fetchRemainingCalories() async {
//     final double savedRemainingCalories = await CacheHelper().getRemainingCalories(bmr);
//     return savedRemainingCalories > 0
//         ? savedRemainingCalories.clamp(0, bmr)
//         : bmr - consumedCalories;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//
//     return FutureBuilder<double>(
//       future: _fetchRemainingCalories(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final double remainingCalories = snapshot.data!.clamp(0.0, bmr);
//         final double consumed = (bmr - remainingCalories).clamp(0.0, bmr);
//         final double completionPercentage = bmr > 0 ? (consumed / bmr).clamp(0.0, 1.0) : 0.0;
//
//         return InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(24),
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.1),
//                   spreadRadius: 1,
//                   blurRadius: 10,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(screenSize.width * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Calories",
//                     style: Styles.textStyle18.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontSize: screenSize.width * 0.045,
//                     ),
//                   ),
//                   SizedBox(height: screenSize.height * 0.01),
//                   Text(
//                     "${bmr.toInt()} kCal",
//                     style: TextStyle(
//                       fontSize: screenSize.width * 0.07,
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xFF96B2FE),
//                     ),
//                   ),
//                   SizedBox(height: screenSize.height * 0.02),
//                   Center(
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         SizedBox(
//                           width: screenSize.width * 0.28,
//                           height: screenSize.width * 0.28,
//                           child: CircularProgressIndicator(
//                             value: completionPercentage,
//                             strokeWidth: screenSize.width * 0.03,
//                             backgroundColor: Colors.grey.shade200,
//                             valueColor: const AlwaysStoppedAnimation(Color(0xFF96B2FE)),
//                           ),
//                         ),
//                         Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               "${remainingCalories.toInt()} kCal",
//                               style: TextStyle(
//                                 fontSize: screenSize.width * 0.05,
//                                 fontWeight: FontWeight.bold,
//                                 color: const Color(0xFF96B2FE),
//                               ),
//                             ),
//                             Text(
//                               "left",
//                               style: TextStyle(
//                                 fontSize: screenSize.width * 0.035,
//                                 color: const Color(0xFF96B2FE),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';
import '../../../../shared/network/local/cache_helper.dart';
// import 'package:fitfork_gp/core/utils/styles.dart';
// import '../../../../shared/network/local/cache_helper.dart';


class CaloriesCard extends StatelessWidget {
  final double bmr;
  final double consumedCalories;
  final VoidCallback onTap;

  const CaloriesCard({
    super.key,
    required this.bmr,
    required this.consumedCalories,
    required this.onTap,
  });

  Future<double> _fetchRemainingCalories() async {
    final double savedRemainingCalories = await CacheHelper().getRemainingCalories(bmr);
    return savedRemainingCalories > 0
        ? savedRemainingCalories.clamp(0, bmr)
        : bmr - consumedCalories;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return FutureBuilder<double>(
      future: _fetchRemainingCalories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final double remainingCalories = snapshot.data!.clamp(0.0, bmr);
        final double consumed = (bmr - remainingCalories).clamp(0.0, bmr);
        final double completionPercentage = bmr > 0 ? (consumed / bmr).clamp(0.0, 1.0) : 0.0;

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
              padding: EdgeInsets.all(screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Calories",
                    style: Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: screenSize.width * 0.045,
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(
                    "${bmr.toInt()} kCal",
                    style: TextStyle(
                      fontSize: screenSize.width * 0.07,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF96B2FE),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: screenSize.width * 0.28,
                          height: screenSize.width * 0.28,
                          child: CircularProgressIndicator(
                            value: completionPercentage,
                            strokeWidth: screenSize.width * 0.03,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF96B2FE)),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${remainingCalories.toInt()} kCal",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF96B2FE),
                              ),
                            ),
                            Text(
                              "left",
                              style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: const Color(0xFF96B2FE),
                              ),
                            ),
                          ],
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
    );
  }
}