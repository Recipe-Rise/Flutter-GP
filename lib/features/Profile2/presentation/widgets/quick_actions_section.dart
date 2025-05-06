import 'package:flutter/material.dart';
import 'quick_action_item.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A2138),
            ),
          ),
          SizedBox(height: 12),
          QuickActionItem(
            icon: Icons.settings,
            label: 'App Settings',
            iconColor: Colors.purple,
            backgroundColor: Color(0xFFF5F0FF),
          ),
          SizedBox(height: 12),
          QuickActionItem(
            icon: Icons.logout,
            label: 'Logout',
            iconColor: Colors.red,
            backgroundColor: Color(0xFFFFF0F0),
          ),
        ],
      ),
    );
  }
}
