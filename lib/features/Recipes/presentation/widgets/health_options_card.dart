import 'package:flutter/material.dart';

class HealthOptionsCard extends StatefulWidget {
  final bool initialDiabetesFriendly;
  final ValueChanged<bool>? onDiabetesFriendlyChanged;

  const HealthOptionsCard({
    Key? key,
    this.initialDiabetesFriendly = false,
    this.onDiabetesFriendlyChanged,
  }) : super(key: key);

  @override
  State<HealthOptionsCard> createState() => _HealthOptionsCardState();
}

class _HealthOptionsCardState extends State<HealthOptionsCard> {
  late bool _isDiabetesFriendly;

  @override
  void initState() {
    super.initState();
    _isDiabetesFriendly = widget.initialDiabetesFriendly;
  }

  void _toggleDiabetesFriendly(bool value) {
    setState(() {
      _isDiabetesFriendly = value;
    });
    widget.onDiabetesFriendlyChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(
              Icons.health_and_safety,
              color: Color(0XFF1B84DF),
              size: 20,
            ),
            const SizedBox(width: 12),
            const Text(
              'Health Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Diabetes Friendly',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Get recipes that are suitable for diabetic diet',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Switch(
                value: _isDiabetesFriendly,
                onChanged: _toggleDiabetesFriendly,
                activeColor: Colors.blue.shade200,
                inactiveThumbColor: Colors.grey.shade400,
                inactiveTrackColor: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
