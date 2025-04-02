import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name,
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Save recipe as favorite functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Recipe saved to favorites")),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image placeholder
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.utensils,
                  color: Colors.grey.shade400,
                  size: 64,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe info row
                  Row(
                    children: [
                      _buildInfoChip(
                        Icons.local_fire_department,
                        Colors.orange.shade700,
                        "${recipe.calories} kcal",
                      ),
                      const SizedBox(width: 12),
                      _buildInfoChip(
                        Icons.access_time,
                        Colors.blue.shade700,
                        "${recipe.prepTimeMinutes} min",
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Ingredients section
                  Text(
                    "Ingredients",
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ...recipe.ingredients
                      .map((ingredient) => _buildListItem(ingredient)),

                  const SizedBox(height: 24),

                  // Instructions section
                  Text(
                    "Instructions",
                    style: Styles.textStyle20
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    recipe.instructions.length,
                    (index) => _buildNumberedListItem(
                      index + 1,
                      recipe.instructions[index],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, Color color, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            text,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Styles.textStyle16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedListItem(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Styles.textStyle16,
            ),
          ),
        ],
      ),
    );
  }
}
