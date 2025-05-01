import 'package:flutter/material.dart';

class WaterContainerOption {
  final String name;
  final int amount;
  final IconData icon;

  const WaterContainerOption({
    required this.name,
    required this.amount,
    this.icon = Icons.local_drink,
  });
}

class CustomContainerSelector extends StatelessWidget {
  final List<WaterContainerOption> options;
  final Function(WaterContainerOption) onOptionSelected;

  const CustomContainerSelector({
    Key? key,
    required this.options,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          final option = options[index];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 70,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => onOptionSelected(option),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(option.icon, color: Colors.blue[700]),
                  ),
                  Text(
                    option.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${option.amount}ml',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
