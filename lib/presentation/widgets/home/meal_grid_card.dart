import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/core/l10n/app_localizations_extension.dart';
import 'package:flutter_app/core/theme/theme.dart';
import 'package:flutter_app/domain/entities/meal.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_app/presentation/widgets/home/meal_image.dart';

class MealGridCard extends StatelessWidget {
  final Meal meal;

  const MealGridCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Card(
        elevation: 0,
        color: theme.colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MealImage(url: meal.thumbnail),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _AddToCartChip(meal: meal),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: MaterialTheme.yellow.value,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        _ratingLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          meal.category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.formatPrice(meal.price),
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      if (meal.discountPercent > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: MaterialTheme.yellow.value,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            context.l10n.discountOff(meal.discountPercent),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _ratingLabel =>
      (4 + (meal.id.hashCode.abs() % 10) / 10.0).toStringAsFixed(1);

  void _navigateToDetails(BuildContext context) {
    Navigator.of(context).pushNamed('/meal-details', arguments: meal);
  }
}

class _AddToCartChip extends StatelessWidget {
  final Meal meal;

  const _AddToCartChip({required this.meal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.primary,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          context.read<CartBloc>().add(AddToCartEvent(meal));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.addedToCart(meal.name)),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            Icons.add_rounded,
            color: theme.colorScheme.onPrimary,
            size: 16,
          ),
        ),
      ),
    );
  }
}
