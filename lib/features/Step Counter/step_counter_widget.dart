import 'package:fitfork_gp/core/services/step_counter_service.dart';
import 'package:flutter/material.dart';

class StepCounterWidget extends StatefulWidget {
  const StepCounterWidget({Key? key}) : super(key: key);

  @override
  State<StepCounterWidget> createState() => _StepCounterWidgetState();
}

class _StepCounterWidgetState extends State<StepCounterWidget> {
  final StepCounterService _stepService = StepCounterService();
  int _dailySteps = 0;
  String _status = 'stopped';

  @override
  void initState() {
    super.initState();
    _initializeStepCounter();
  }

  Future<void> _initializeStepCounter() async {
    await _stepService.startListening();

    // Listen to step updates
    _stepService.stepsStream.listen((steps) {
      if (mounted) {
        setState(() {
          _dailySteps = steps;
        });
      }
    });

    // Listen to status updates
    _stepService.statusStream.listen((status) {
      if (mounted) {
        setState(() {
          _status = status;
        });
      }
    });

    // Initialize with current values
    setState(() {
      _dailySteps = _stepService.dailySteps;
      _status = _stepService.pedestrianStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_walk,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Daily Steps',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _dailySteps.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Status: ${_status.toUpperCase()}',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: (_dailySteps / 10000).clamp(0.0, 1.0),
            backgroundColor: Colors.white30,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Goal: 10,000 steps',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
