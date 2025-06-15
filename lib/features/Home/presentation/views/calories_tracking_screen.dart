// import 'package:fitfork_gp/features/Home/presentation/widgets/calorie_summary_card.dart';
// import 'package:fitfork_gp/features/Home/presentation/widgets/macronutrient_Progress.dart';
// import 'package:fitfork_gp/features/Home/presentation/widgets/meal_entery.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class CaloriesTrackingScreen extends StatelessWidget {
//   const CaloriesTrackingScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black54),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: const Text(
//           'Calories',
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add, color: Colors.black54),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: const SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CalorieSummaryCard(
//                 consumedCalories: 760,
//                 totalCalories: 2000,
//                 remainingCalories: 1240,
//                 burnedCalories: 320,
//               ),
//
//               SizedBox(height: 24),
//
//               // Macronutrients section
//               Text(
//                 'Macronutrients',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF3A3A3A)),
//               ),
//
//               SizedBox(height: 16),
//
//               MacronutrientProgress(
//                 color: Colors.blue,
//                 label: 'Proteins',
//                 current: 27,
//                 goal: 75,
//                 percentage: 36,
//               ),
//
//               SizedBox(height: 12),
//
//               MacronutrientProgress(
//                 color: Colors.orange,
//                 label: 'Carbs',
//                 current: 96,
//                 goal: 250,
//                 percentage: 38,
//               ),
//
//               SizedBox(height: 12),
//
//               MacronutrientProgress(
//                 color: Colors.pink,
//                 label: 'Fats',
//                 current: 22,
//                 goal: 67,
//                 percentage: 33,
//               ),
//
//               SizedBox(height: 24),
//
//               Text(
//                 'Today\'s Meals',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF3A3A3A)),
//               ),
//
//               SizedBox(height: 16),
//
//               MealEntry(
//                 mealType: 'Breakfast',
//                 mealItems: 'Toast, eggs, coffee',
//                 calories: 320,
//                 icon: Icons.wb_sunny_outlined,
//                 iconBackgroundColor: Color(0xFFFFF3E0),
//                 iconColor: Colors.orange,
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         backgroundColor: const Color(0xFF26A69A),
//         child: const Icon(Icons.add, size: 32),
//       ),
//     );
//   }


// }



// Enhanced CaloriesTrackingScreen with animations and interactive calorie details
// ---------------------------------------------------------------
// ✨ New in this version:
//  • Subtle entrance animations for every section (flutter_animate)
//  • Tap‑to‑detail bottom‑sheet on the summary card
//  • Animated macronutrient bars with tweening progress
//  • Lightweight line chart previewing calorie intake throughout the day (fl_chart)
//  • Removed the floating action button – navigation happens via taps instead
//
// 👉 Dependencies (add to your pubspec.yaml):
//    flutter_animate: ^4.5.0
//    fl_chart: ^0.68.0
// ---------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/calorie_summary_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/meal_entery.dart';

class CaloriesTrackingScreen extends StatefulWidget {
  final double bmr;
  final double consumedCalories;
  final double remainingCalories;

  const CaloriesTrackingScreen({
    super.key,
    required this.bmr,
    required this.consumedCalories,
    required this.remainingCalories,
  });

  @override
  State<CaloriesTrackingScreen> createState() => _CaloriesTrackingScreenState();
}

class _CaloriesTrackingScreenState extends State<CaloriesTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(

        automaticallyImplyLeading: true,
        title: const Text(
          'Calories',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _showCalorieDetails(context),
              child: CalorieSummaryCard(
                consumedCalories: widget.consumedCalories,
                totalCalories: widget.bmr,
                remainingCalories: widget.remainingCalories,
              ),
            ).animate().fade(duration: 400.ms).slideY(begin: .1),

            const SizedBox(height: 24),

            const _AnimatedSectionHeader('Macronutrients'),
            const SizedBox(height: 16),

            const _AnimatedMacronutrientProgress(
              color: Colors.blue,
              label: 'Proteins',
              current: 27,
              goal: 75,
            ),
            const SizedBox(height: 12),
            const _AnimatedMacronutrientProgress(
              color: Colors.orange,
              label: 'Carbs',
              current: 96,
              goal: 250,
            ),
            const SizedBox(height: 12),
            const _AnimatedMacronutrientProgress(
              color: Colors.pink,
              label: 'Fats',
              current: 22,
              goal: 67,
            ),

            const SizedBox(height: 32),

            const _AnimatedSectionHeader('Calorie Trend (Today)'),
            const SizedBox(height: 16),
            const _CaloriesLineChart()
                .animate()
                .fade(duration: 500.ms)
                .slideY(begin: .1),

            const SizedBox(height: 32),

            const _AnimatedSectionHeader('Today’s Meals'),
            const SizedBox(height: 16),

            const MealEntry(
              mealType: 'Breakfast',
              mealItems: 'Toast, eggs, coffee',
              calories: 320,
              icon: Icons.wb_sunny_outlined,
              iconBackgroundColor: Color(0xFFFFF3E0),
              iconColor: Colors.orange,
            ).animate().fade(duration: 400.ms).slideY(begin: .1),
          ],
        ),
      ),
    );
  }

  void _showCalorieDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Daily Calorie Breakdown',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            const _CaloriesLineChart(showAxes: true),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
// ───────────────────── UI building blocks ─────────────────────

class _AnimatedSectionHeader extends StatelessWidget {
  final String text;
  const _AnimatedSectionHeader(this.text);

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF3A3A3A),
    ),
  ).animate().fade(duration: 300.ms).slideY(begin: .08);
}

/// Progress bar that tweens smoothly from 0 → percentage.
class _AnimatedMacronutrientProgress extends StatelessWidget {
  final Color color;
  final String label;
  final double current;
  final double goal;

  const _AnimatedMacronutrientProgress({
    required this.color,
    required this.label,
    required this.current,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (current / goal).clamp(0, 1).toDouble();
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: percentage),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
                const Spacer(),
                Text('${(value * 100).round()}%',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                minHeight: 8,
                value: value,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Lightweight line chart using fl_chart.
class _CaloriesLineChart extends StatelessWidget {
  final bool showAxes;
  const _CaloriesLineChart({this.showAxes = false});

  @override
  Widget build(BuildContext context) {
    // Replace with live data from your state layer 🔄
    final dataPoints = [
      FlSpot(0, 0),
      FlSpot(2, 120),
      FlSpot(4, 250),
      FlSpot(6, 400),
      FlSpot(8, 550),
      FlSpot(10, 760),
    ];

    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            show: showAxes,
            bottomTitles: AxisTitles(
              axisNameWidget: const Text('Hour'),
              sideTitles: SideTitles(
                showTitles: showAxes,
                interval: 2,
                getTitlesWidget: (v, _) => Text('${v.toInt()}'),
              ),
            ),
            leftTitles: AxisTitles(
              axisNameWidget: const Text('kcal'),
              sideTitles: SideTitles(
                showTitles: showAxes,
                interval: 200,
                getTitlesWidget: (v, _) => Text('${v.toInt()}'),
              ),
            ),
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 10,
          minY: 0,
          maxY: 1000,
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints,
              isCurved: true,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }
}

