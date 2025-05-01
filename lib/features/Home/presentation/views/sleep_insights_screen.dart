import 'package:fitfork_gp/features/Home/data/models/sleep_model.dart';
import 'package:flutter/material.dart';
import '../widgets/sleep_summary_card.dart';
import '../widgets/analysis_section.dart';
import '../widgets/heart_rate_chart.dart';
import '../widgets/weekly_sleep_chart.dart';

class SleepInsightsScreen extends StatelessWidget {
  const SleepInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sleepData = SleepData(
      duration: const Duration(hours: 8, minutes: 20),
      sleepScore: 83,
      startTime: const TimeOfDay(hour: 23, minute: 40),
      endTime: const TimeOfDay(hour: 8, minute: 0),
      analyses: const [
        'More deep sleep than last week',
        'Consistent sleep schedule',
      ],
      heartRateData: List.generate(
        24,
        (index) => HeartRatePoint(
          hour: index * 0.5,
          bpm: 50 + (index < 12 ? index * 2.5 : (24 - index) * 2.5),
        ),
      ),
      weeklySleepData: [
        DailySleep(day: 'M', hours: 6.5),
        DailySleep(day: 'T', hours: 6),
        DailySleep(day: 'W', hours: 7),
        DailySleep(day: 'T', hours: 8),
        DailySleep(day: 'F', hours: 7.5),
        DailySleep(day: 'S', hours: 6),
        DailySleep(day: 'S', hours: 7.2),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Sleep Insights',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SleepSummaryCard(
              duration: sleepData.duration,
              sleepScore: sleepData.sleepScore,
              startTime: sleepData.startTime,
              endTime: sleepData.endTime,
              onEdit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit sleep data')),
                );
              },
            ),
            const SizedBox(height: 16),
            AnalysisSection(analyses: sleepData.analyses),
            const SizedBox(height: 24),
            HeartRateChart(data: sleepData.heartRateData),
            const SizedBox(height: 24),
            WeeklySleepChart(
              data: sleepData.weeklySleepData,
              onSetGoal: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Set sleep goal')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
