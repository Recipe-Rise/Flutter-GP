import 'package:flutter/material.dart';

class ChoiceChipsGrid extends StatelessWidget {
  final List<String> options;

  final List<String> selectedOptions;

  final Function(List<String>) onSelectionChanged;

  final int crossAxisCount;

  const ChoiceChipsGrid({
    Key? key,
    required this.options,
    required this.selectedOptions,
    required this.onSelectionChanged,
    this.crossAxisCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: options.map((option) {
        final isSelected = selectedOptions.contains(option);
        return FilterChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (selected) {
            final newSelection = List<String>.from(selectedOptions);
            if (selected) {
              newSelection.add(option);
            } else {
              newSelection.remove(option);
            }
            onSelectionChanged(newSelection);
          },
          backgroundColor: Colors.grey.shade200,
          selectedColor: Colors.blue.shade200,
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? Colors.blue.shade300 : Colors.transparent,
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
      }).toList(),
    );
  }
}
