import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/core/l10n/app_localizations_extension.dart';
import 'package:flutter_app/core/theme/theme.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_state.dart';

class CartAppBarAction extends StatelessWidget {
  final VoidCallback onTap;

  const CartAppBarAction({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final int count = state.totalQuantity;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Badge(
            isLabelVisible: count > 0,
            label: Text(
              count > 99 ? '99+' : '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: MaterialTheme.yellow.value,
            offset: const Offset(-3, 5),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: theme.colorScheme.onSurface,
              ),
              onPressed: onTap,
              tooltip: context.l10n.cartSummary(count),
            ),
          ),
        );
      },
    );
  }
}
