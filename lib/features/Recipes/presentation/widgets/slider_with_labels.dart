import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SliderWithLabels extends StatelessWidget {
  final double min;
  final double max;
  final double value;
  final String label;
  final ValueChanged<double> onChanged;
  final IconData? icon;
  final Color? activeColor;
  final Color? inactiveColor;

  const SliderWithLabels({
    Key? key,
    required this.min,
    required this.max,
    required this.value,
    required this.label,
    required this.onChanged,
    this.icon,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultActiveColor = activeColor ?? theme.primaryColor;
    final defaultInactiveColor = inactiveColor ?? Colors.grey.shade300;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and label
          Row(
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    icon,
                    size: 16,
                    color: defaultActiveColor,
                  ),
                ),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Slider with min/max labels
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: defaultActiveColor,
              inactiveTrackColor: defaultInactiveColor,
              thumbColor: Colors.white,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 10,
                elevation: 4,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              overlayColor: defaultActiveColor.withOpacity(0.2),
              trackHeight: 4,
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              label: '${value.toInt()} min',
              onChanged: onChanged,
            ),
          ),

          // Min/Max labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${min.toInt()} min',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${max.toInt()} min',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
