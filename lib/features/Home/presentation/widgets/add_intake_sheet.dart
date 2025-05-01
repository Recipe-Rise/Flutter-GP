import 'package:fitfork_gp/features/Home/data/models/water_log_entery.dart';
import 'package:flutter/material.dart';
import 'custom_container_selector.dart';

class AddIntakeSheet extends StatefulWidget {
  final Function(WaterLogEntry) onAddEntry;

  const AddIntakeSheet({
    Key? key,
    required this.onAddEntry,
  }) : super(key: key);

  @override
  State<AddIntakeSheet> createState() => _AddIntakeSheetState();
}

class _AddIntakeSheetState extends State<AddIntakeSheet> {
  final TextEditingController _customAmountController = TextEditingController();

  final List<WaterContainerOption> _containerOptions = const [
    WaterContainerOption(name: 'Glass', amount: 250, icon: Icons.local_drink),
    WaterContainerOption(
        name: 'Bottle', amount: 500, icon: Icons.local_drink_rounded),
    WaterContainerOption(name: 'Mug', amount: 300, icon: Icons.coffee),
    WaterContainerOption(name: 'Cup', amount: 200, icon: Icons.coffee_maker),
  ];

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  void _addCustomAmount() {
    final amountText = _customAmountController.text.trim();
    if (amountText.isEmpty) return;

    final amount = int.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount')),
      );
      return;
    }

    final entry = WaterLogEntry(
      type: 'Custom',
      amount: amount,
      time: DateTime.now(),
    );

    widget.onAddEntry(entry);
    Navigator.pop(context);
    _customAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Water Intake',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Container',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          CustomContainerSelector(
            options: _containerOptions,
            onOptionSelected: (option) {
              final entry = WaterLogEntry(
                type: option.name,
                amount: option.amount,
                time: DateTime.now(),
              );
              widget.onAddEntry(entry);
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Custom Amount',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _customAmountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter amount in ml',
                    border: OutlineInputBorder(),
                    suffixText: 'ml',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12), // Adjusted padding for better appearance
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _addCustomAmount,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(80, 48),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
