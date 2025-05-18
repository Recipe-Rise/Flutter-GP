import 'package:fitfork_gp/features/Home/data/models/water_log_entery.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/add_intake_sheet.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/edit_log_dialoug.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/hydration_progress_card.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/water_log_item.dart';
import 'package:fitfork_gp/features/Home/presentation/widgets/weekly_progress_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterIntakeScreen extends StatefulWidget {
  const WaterIntakeScreen({Key? key}) : super(key: key);

  @override
  State<WaterIntakeScreen> createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen> {
  final double _dailyGoal = 8.0;
  double _currentIntake = 4.0;

  final List<WaterLogEntry> _waterLogs = [
    WaterLogEntry(
      type: 'Glass',
      amount: 250,
      time: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 30),
    ),
    WaterLogEntry(
      type: 'Bottle',
      amount: 500,
      time: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 11, 45),
    ),
    WaterLogEntry(
      type: 'Mug',
      amount: 300,
      time: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 15),
    ),
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
            final amountDifference = updatedEntry.amount - logEntry.amount;

            _currentIntake += amountDifference / 1000;

            _waterLogs[index] = updatedEntry;
          });
        },
      ),
    );
  }

  int _getGlassesNeeded() {
    double litersMissing = _dailyGoal - _currentIntake;
    return (litersMissing * 1000 / 250).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Water Intake'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HydrationProgressCard(
              currentIntake: _currentIntake,
              goalIntake: _dailyGoal,
              glassesNeeded: _getGlassesNeeded(),
            ),
            const SizedBox(height: 24),
            const Text(
              "Today's Log",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _waterLogs.length,
                itemBuilder: (context, index) {
                  final log = _waterLogs[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: WaterLogItem(
                      logEntry: log,
                      onEdit: () {
                        _editWaterLog(index);
                      },
                      onDelete: () {
                        setState(() {
                          _currentIntake -= log.amount / 1000;
                          _waterLogs.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Weekly Progress",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
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