import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/core/l10n/app_localizations_extension.dart';
import 'package:flutter_app/core/theme/theme.dart';
import 'package:flutter_app/domain/entities/meal.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_app/presentation/widgets/home/meal_image.dart';

class HotOffersSection extends StatelessWidget {
  final List<Meal> meals;

  const HotOffersSection({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (meals.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 176,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: meals.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final meal = meals[index];
          return _HotOfferCard(meal: meal);
        },
      ),
    );
  }
}

class _HotOfferCard extends StatelessWidget {
  final Meal meal;

  const _HotOfferCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed('/meal-details', arguments: meal),
      child: Container(
        width: 148,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 92,
                  child: MealImage(
                    url: meal.thumbnail,
                    placeholderIconSize: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        meal.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: 12,
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
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.formatPrice(meal.price),
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          _MiniAddButton(meal: meal),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 6,
              top: 6,
              child: _DiscountBadge(percent: meal.discountPercent),
            ),
          ],
        ),
      ),
    );
  }

  String get _ratingLabel =>
      (4 + (meal.id.hashCode.abs() % 10) / 10.0).toStringAsFixed(1);
}

class _DiscountBadge extends StatelessWidget {
  final int percent;

  const _DiscountBadge({required this.percent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: MaterialTheme.yellow.value,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        context.l10n.discountPercentOff(percent),
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _MiniAddButton extends StatelessWidget {
  final Meal meal;

  const _MiniAddButton({required this.meal});

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
              content: Text(context.l10n.addedToCart),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            Icons.add_rounded,
            color: theme.colorScheme.onPrimary,
            size: 14,
          ),
        ),
      ),
    );
  }
}
