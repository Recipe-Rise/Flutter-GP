import 'dart:async';
import 'dart:io';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounterService {
  static final StepCounterService _instance = StepCounterService._internal();
  factory StepCounterService() => _instance;
  StepCounterService._internal();

  StreamSubscription<StepCount>? _stepCountStream;
  StreamSubscription<PedestrianStatus>? _pedestrianStatusStream;

  int _currentSteps = 0;
  int _dailySteps = 0;
  String _pedestrianStatus = 'stopped';

  int get currentSteps => _currentSteps;
  int get dailySteps => _dailySteps;
  String get pedestrianStatus => _pedestrianStatus;

  final StreamController<int> _stepsController =
  StreamController<int>.broadcast();
  final StreamController<String> _statusController =
  StreamController<String>.broadcast();

  Stream<int> get stepsStream => _stepsController.stream;
  Stream<String> get statusStream => _statusController.stream;

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.activityRecognition.request();
      return status.isGranted;
    }
    return true;
  }

  Future<void> startListening() async {
    final hasPermission = await requestPermissions();
    if (!hasPermission) return;

    await _loadDailySteps();

    try {
      _stepCountStream = Pedometer.stepCountStream.listen(
        onStepCount,
        onError: onStepCountError,
      );

      _pedestrianStatusStream = Pedometer.pedestrianStatusStream.listen(
        onPedestrianStatusChanged,
        onError: onPedestrianStatusError,
      );
    } catch (e) {
      print('Error starting pedometer: $e');
    }
  }

  void onStepCount(StepCount event) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastSavedDate = prefs.getString('last_step_date') ?? '';

    // Reset daily steps if it's a new day
    if (lastSavedDate != today) {
      _dailySteps = 0;
      await prefs.setString('last_step_date', today);
      await prefs.setInt('daily_steps', 0);
    }

    _currentSteps = event.steps;

    final savedDailySteps = prefs.getInt('daily_steps') ?? 0;
    _dailySteps = _currentSteps - (prefs.getInt('step_offset') ?? 0);

    if (_dailySteps < 0) _dailySteps = 0;

    await prefs.setInt('daily_steps', _dailySteps);

    _stepsController.add(_dailySteps);
  }

  void onStepCountError(error) {
    print('Step Count Error: $error');
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    _pedestrianStatus = event.status;
    _statusController.add(_pedestrianStatus);
  }

  void onPedestrianStatusError(error) {
    print('Pedestrian Status Error: $error');
  }

  Future<void> _loadDailySteps() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastSavedDate = prefs.getString('last_step_date') ?? '';

    if (lastSavedDate == today) {
      _dailySteps = prefs.getInt('daily_steps') ?? 0;
    } else {
      _dailySteps = 0;
      await prefs.setString('last_step_date', today);
      await prefs.setInt('daily_steps', 0);
    }
  }

  Future<void> resetDailySteps() async {
    final prefs = await SharedPreferences.getInstance();
    _dailySteps = 0;
    await prefs.setInt('daily_steps', 0);
    _stepsController.add(_dailySteps);
  }

  void dispose() {
    _stepCountStream?.cancel();
    _pedestrianStatusStream?.cancel();
    _stepsController.close();
    _statusController.close();
  }
}