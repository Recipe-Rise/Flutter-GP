import 'package:fitfork_gp/features/Recipes/data/models/recipe.dart';
import 'package:fitfork_gp/features/Recipes/data/models/recipe_rec_model.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeCard extends StatelessWidget {
  final RecipeRecommendation recipe;
  final VoidCallback onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    bool isDiabetesFriendly = (recipe.calories ?? 0).toDouble() <= 300;

    return BlocConsumer<RecipeRecommendationCubit,RecipesRecommendationStates>(
      listener: (context,state){},
      builder: (context,state){
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            recipe.name ?? 'Unknown Recipe',
                            style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF9CA3AF),
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFC8019), Color(0xFFFF6B35)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.local_fire_department,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Calories',
                                  style: Styles.textStyle14.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xFF6B7280),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${recipe.calories}',
                                  style: Styles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.access_time,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: Styles.textStyle14.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xFF6B7280),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${recipe.minutes} min',
                                  style: Styles.textStyle14.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isDiabetesFriendly
                                    ? const Color(0xFFDCFCE7)
                                    : const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                isDiabetesFriendly
                                    ? Icons.check_circle
                                    : Icons.dinner_dining_outlined,
                                color: isDiabetesFriendly
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFF9CA3AF),
                                size: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isDiabetesFriendly
                                  ? 'Diabetes\nFriendly'
                                  : 'Regular\nRecipe',
                              textAlign: TextAlign.center,
                              style: Styles.textStyle14.copyWith(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: isDiabetesFriendly
                                    ? const Color(0xFF059669)
                                    : const Color(0xFF6B7280),
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDiabetesFriendly
                        ? [const Color(0xFF10B981), const Color(0xFF059669)]
                        : [const Color(0xFFD1D5DB), const Color(0xFF9CA3AF)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}