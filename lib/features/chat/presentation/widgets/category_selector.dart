import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => onCategorySelected(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: index == selectedIndex
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade600,
                          fontSize: 18,
                          fontWeight: index == selectedIndex
                              ? FontWeight.bold
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 3,
                      width: 60,
                      decoration: BoxDecoration(
                        color: index == selectedIndex
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
