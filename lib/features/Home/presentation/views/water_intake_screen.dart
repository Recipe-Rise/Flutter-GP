import 'package:fitfork_gp/features/Home/data/models/water_log_entery.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/add_intake_sheet.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/edit_log_dialoug.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/hydration_progress_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/water_log_item.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/weekly_progress_chart.dart';
import 'package:flutter/material.dart';

class WaterIntakeScreen extends StatefulWidget {
  const WaterIntakeScreen({Key? key}) : super(key: key);

  @override
  State<WaterIntakeScreen> createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  final double _dailyGoal = 8.0; // in liters
  double _currentIntake = 4.0;

  final List<WaterLogEntry> _waterLogs = [
    WaterLogEntry(type: 'Glass', amount: 250, time: DateTime.now().subtract(const Duration(hours: 6))),
    WaterLogEntry(type: 'Bottle', amount: 500, time: DateTime.now().subtract(const Duration(hours: 3))),
    WaterLogEntry(type: 'Mug', amount: 300, time: DateTime.now().subtract(const Duration(hours: 1))),
  ];

  final List<double> _weeklyData = [2.5, 4.0, 6.0, 8.0, 7.5, 7.0, 0.0];

  void _addWaterIntake() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddIntakeSheet(
        onAddEntry: (entry) {
          setState(() {
            _waterLogs.add(entry);
            _currentIntake += entry.amount / 1000;
          });
        },
      ),
    );
  }

  void _editWaterLog(int index) {
    final logEntry = _waterLogs[index];
    showDialog(
      context: context,
      builder: (context) => EditLogDialog(
        logEntry: logEntry,
        onSave: (updatedEntry) {
          setState(() {
            final difference = updatedEntry.amount - logEntry.amount;
            _currentIntake += difference / 1000;
            _waterLogs[index] = updatedEntry;
          });
        },
      ),
    );
  }

  int _getGlassesNeeded() {
    double litersRemaining = _dailyGoal - _currentIntake;
    return (litersRemaining * 1000 / 250).ceil();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final padding = EdgeInsets.symmetric(horizontal: size.width * 0.04);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Water Intake'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: padding.left,
          right: padding.right,
          top: 16,
          bottom: 80, // for safe space with FAB
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HydrationProgressCard(
              currentIntake: _currentIntake,
              goalIntake: _dailyGoal,
              glassesNeeded: _getGlassesNeeded(),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "Today's Log",
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            ..._waterLogs.asMap().entries.map((entry) {
              final index = entry.key;
              final log = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: WaterLogItem(
                  logEntry: log,
                  onEdit: () => _editWaterLog(index),
                  onDelete: () {
                    setState(() {
                      _currentIntake -= log.amount / 1000;
                      _waterLogs.removeAt(index);
                    });
                  },
                ),
              );
            }).toList(),
            SizedBox(height: size.height * 0.03),
            Text(
              "Weekly Progress",
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.015),
            SizedBox(
              height: size.height * 0.25,
              child: WeeklyProgressChart(
                weeklyData: _weeklyData,
                goalValue: _dailyGoal,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWaterIntake,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
