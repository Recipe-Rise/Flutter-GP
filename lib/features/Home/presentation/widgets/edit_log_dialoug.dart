import 'package:fitfork_gp/features/Home/data/models/water_log_entery.dart';
import 'package:flutter/material.dart';

class EditLogDialog extends StatefulWidget {
  final WaterLogEntry logEntry;
  final Function(WaterLogEntry) onSave;

  const EditLogDialog({
    Key? key,
    required this.logEntry,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditLogDialog> createState() => _EditLogDialogState();
}

class _EditLogDialogState extends State<EditLogDialog> {
  late TextEditingController _amountController;
  late TimeOfDay _selectedTime;
  late String _selectedType;

  final List<String> _containerTypes = [
    'Glass',
    'Bottle',
    'Mug',
    'Cup',
    'Custom'
  ];

  @override
  void initState() {
    super.initState();
    _amountController =
        TextEditingController(text: widget.logEntry.amount.toString());
    _selectedTime = TimeOfDay.fromDateTime(widget.logEntry.time);
    _selectedType = widget.logEntry.type;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Water Intake'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Container Type',
                border: OutlineInputBorder(),
              ),
              value: _selectedType,
              items: _containerTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedType = value;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (ml)',
                border: OutlineInputBorder(),
                suffixText: 'ml',
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Time'),
              subtitle: Text(_formatTimeOfDay(_selectedTime)),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );

                if (pickedTime != null && pickedTime != _selectedTime) {
                  setState(() {
                    _selectedTime = pickedTime;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final amount =
                int.tryParse(_amountController.text) ?? widget.logEntry.amount;

            final DateTime oldDateTime = widget.logEntry.time;
            final DateTime newDateTime = DateTime(
              oldDateTime.year,
              oldDateTime.month,
              oldDateTime.day,
              _selectedTime.hour,
              _selectedTime.minute,
            );

            final updatedEntry = widget.logEntry.copyWith(
              type: _selectedType,
              amount: amount,
              time: newDateTime,
            );

            widget.onSave(updatedEntry);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}