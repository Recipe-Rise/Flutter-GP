import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RangeSliderWithLabels extends StatelessWidget {
  final double min;
  final double max;
  final RangeValues values;
  final String startLabel;
  final String endLabel;
  final ValueChanged<RangeValues> onChanged;
  final IconData? startIcon;
  final IconData? endIcon;
  final Color? activeColor;
  final Color? inactiveColor;
  final int? divisions;

  const RangeSliderWithLabels({
    Key? key,
    required this.min,
    required this.max,
    required this.values,
    required this.startLabel,
    required this.endLabel,
    required this.onChanged,
    this.startIcon,
    this.endIcon,
    this.activeColor,
    this.inactiveColor,
    this.divisions,
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
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icons
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabelWithIcon(
                  icon: startIcon,
                  label: startLabel,
                  color: defaultActiveColor,
                ),
                _buildLabelWithIcon(
                  icon: endIcon,
                  label: endLabel,
                  color: defaultActiveColor,
                ),
              ],
            ),
          ),

          // Range Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: defaultActiveColor,
              inactiveTrackColor: defaultInactiveColor,
              thumbColor: Colors.white,
              rangeThumbShape: const RoundRangeSliderThumbShape(
                enabledThumbRadius: 10,
                elevation: 4,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              overlayColor: defaultActiveColor.withOpacity(0.2),
              rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
              trackHeight: 4,
            ),
            child: RangeSlider(
              values: values,
              min: min,
              max: max,
              divisions: divisions ?? ((max - min) / 50).floor(),
              labels: RangeLabels(
                startLabel,
                endLabel,
              ),
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
                  '${min.toInt()} cal',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${max.toInt()} cal',
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

  Widget _buildLabelWithIcon({
    required IconData? icon,
    required String label,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              icon,
              size: 16,
              color: color,
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
    );
  }
}
