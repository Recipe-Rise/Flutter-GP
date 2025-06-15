import 'package:flutter/material.dart';
import '../../core/sevices/step_counter_service.dart';

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

    _stepService.stepsStream.listen((steps) {
      if (mounted) {
        setState(() {
          _dailySteps = steps;
        });
      }
    });

    _stepService.statusStream.listen((status) {
      if (mounted) {
        setState(() {
          _status = status;
        });
      }
    });

    setState(() {
      _dailySteps = _stepService.dailySteps;
      _status = _stepService.pedestrianStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Responsive header row
          Row(
            children: [
              const Icon(Icons.directions_walk, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Daily Steps',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _dailySteps.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.09,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Status: ${_status.toUpperCase()}',
            style: TextStyle(
              color: Colors.white70,
              fontSize: size.width * 0.035,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: (_dailySteps / 10000).clamp(0.0, 1.0),
            backgroundColor: Colors.white30,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          Text(
            'Goal: 10,000 steps',
            style: TextStyle(
              color: Colors.white70,
              fontSize: size.width * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
