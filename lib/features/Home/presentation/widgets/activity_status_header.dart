import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ActivityStatusHeader extends StatelessWidget {
  const ActivityStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Text(
        "Activity Status",
        style: Styles.textStyle26.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
