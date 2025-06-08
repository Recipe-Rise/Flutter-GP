import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeHeaderWidget extends StatelessWidget {
  final Recipe recipe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onBackPressed;

  const RecipeHeaderWidget({
    Key? key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 78, 141, 224),
              Color.fromARGB(255, 31, 22, 199)
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onBackPressed,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _MetaItem(
                  // icon: Icons.access_time,
                  text: '⏱️  ' + recipe.prepTimeMinutes.toString() + ' min',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  // final IconData icon;
  final String text;

  const _MetaItem({
    // required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon(
        //   icon,
        //   color: Colors.white.withOpacity(0.9),
        //   size: 16,
        // ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
