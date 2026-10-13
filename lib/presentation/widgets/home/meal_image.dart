import 'package:flutter/material.dart';

class MealImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? placeholderIconSize;

  const MealImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.placeholderIconSize = 36,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: theme.colorScheme.surfaceContainerHighest,
          alignment: Alignment.center,
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                theme.colorScheme.primary,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: theme.colorScheme.surfaceContainerHighest,
          alignment: Alignment.center,
          child: Icon(
            Icons.restaurant_menu,
            size: placeholderIconSize,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
      },
    );
  }
}
