import 'package:flutter/material.dart';

class ActivityLevelOption extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const ActivityLevelOption({
    Key? key,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          trailing: isSelected
              ? Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                )
              : Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                    color: Colors.transparent,
                  ),
                ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          dense: false,
          visualDensity: VisualDensity.comfortable,
        ),
      ),
    );
  }
}
