import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/meal.dart';
import 'package:flutter_app/presentation/widgets/home/meal_grid_card.dart';

class MealGridSliver extends StatelessWidget {
  final List<Meal> meals;

  const MealGridSliver({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => MealGridCard(meal: meals[index]),
          childCount: meals.length,
        ),
      ),
    );
  }
}