import 'package:flutter/material.dart';

class RecipesCountCard extends StatefulWidget {
  final int initialCount;
  final ValueChanged<int>? onCountChanged;
  final int minCount;
  final int maxCount;

  const RecipesCountCard({
    Key? key,
    this.initialCount = 5,
    this.onCountChanged,
    this.minCount = 1,
    this.maxCount = 20,
  }) : super(key: key);

  @override
  State<RecipesCountCard> createState() => _RecipesCountCardState();
}

class _RecipesCountCardState extends State<RecipesCountCard> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _decrementCount() {
    if (_count > widget.minCount) {
      setState(() {
        _count--;
      });
      widget.onCountChanged?.call(_count);
    }
  }

  void _incrementCount() {
    if (_count < widget.maxCount) {
      setState(() {
        _count++;
      });
      widget.onCountChanged?.call(_count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Icon(
              Icons.receipt_long,
              color: Color(0XFF1B84DF),
              // color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            const Text(
              'Number of Recipes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Select how many recipes you want',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _decrementCount,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _count > widget.minCount
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: _count > widget.minCount
                            ? Colors.blue
                            : Colors.grey.shade400,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text(
                    '$_count',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: _incrementCount,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _count < widget.maxCount
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: _count < widget.maxCount
                            ? Colors.blue
                            : Colors.grey.shade400,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
