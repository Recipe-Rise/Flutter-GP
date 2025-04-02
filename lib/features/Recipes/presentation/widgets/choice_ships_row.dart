import 'package:flutter/material.dart';

/// A row of single-selection choice chips.
///
/// Displays a horizontal wrap of filter chips where only one option can be selected at a time.
class ChoiceChipsRow extends StatelessWidget {
  /// The list of options to display.
  final List<String> options;

  /// The currently selected option.
  final String selectedOption;

  /// Callback when selection changes, provides the newly selected option.
  final Function(String) onSelectionChanged;

  const ChoiceChipsRow({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: options.map((option) {
        final isSelected = selectedOption == option;
        return FilterChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              onSelectionChanged(option);
            } else {
              onSelectionChanged('');
            }
          },
          backgroundColor: Colors.grey.shade200,
          selectedColor: Colors.blue.shade300,
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
