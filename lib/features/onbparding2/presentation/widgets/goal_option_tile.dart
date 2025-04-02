import 'package:flutter/material.dart';

class GoalOptionTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const GoalOptionTile(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
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
            ),
          ),
          trailing: isSelected
              ? Icon(
                  Icons.check_box,
                  color: Colors.blue,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }
}
