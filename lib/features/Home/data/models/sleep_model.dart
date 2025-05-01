import 'package:flutter/material.dart';

class SleepData {
  final Duration duration;
  final int sleepScore;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<String> analyses;
  final List<HeartRatePoint> heartRateData;
  final List<DailySleep> weeklySleepData;

  const SleepData({
    required this.duration,
    required this.sleepScore,
    required this.startTime,
    required this.endTime,
    required this.analyses,
    required this.heartRateData,
    required this.weeklySleepData,
  });
}

class HeartRatePoint {
  final double hour;
  final double bpm;

  const HeartRatePoint({
    required this.hour,
    required this.bpm,
  });
}

class DailySleep {
  final String day;
  final double hours;

  const DailySleep({
    required this.day,
    required this.hours,
  });
}
