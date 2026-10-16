import 'package:flutter/material.dart';
import 'package:flutter_app/domain/entities/order.dart';
import 'package:flutter_app/presentation/blocs/orders/orders_bloc.dart';
import 'package:flutter_app/presentation/blocs/orders/orders_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/domain/entities/cart_item.dart';
import 'package:flutter_app/l10n/app_localizations.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_event.dart';
import 'package:flutter_app/presentation/blocs/cart/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          l10n.yourCart,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: l10n.clearCart,
                onPressed: () {
                  _showClearCartDialog(context);
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return _buildEmptyCart(context);
          }

          const double deliveryFee = 2.50;
          final double subtotal = state.totalPrice;
          final double grandTotal = subtotal + deliveryFee;

          return CustomScrollView(
            slivers: [
              // 1. List of Cart Items
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = state.items[index];
                      return _CartItemTile(item: item);
                    },
                    childCount: state.items.length,
                  ),
                ),
              ),

              // 2. Payment Method Selection
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        l10n.paymentMethod,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withOpacity(0.5),
                          ),
                        ),
                        child: Column(
                          children: [
                            RadioListTile<String>(
                              title: Text(l10n.cashOnDelivery),
                              subtitle: Text(l10n.payWhenFoodArrives),
                              value: 'Cash on Delivery',
                              groupValue: _selectedPaymentMethod,
                              activeColor: colorScheme.primary,
                              secondary: Icon(
                                Icons.payments_outlined,
                                color: colorScheme.primary,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedPaymentMethod = value);
                                }
                              },
                            ),
                            Divider(
                              height: 1,
                              color: colorScheme.outlineVariant.withOpacity(0.5),
                            ),
                            RadioListTile<String>(
                              title: Text(l10n.creditDebitCard),
                              subtitle: Text(l10n.fastSecureOnlinePayment),
                              value: 'Credit Card',
                              groupValue: _selectedPaymentMethod,
                              activeColor: colorScheme.primary,
                              secondary: Icon(
                                Icons.credit_card_outlined,
                                color: colorScheme.primary,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() => _selectedPaymentMethod = value);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Bill Summary Breakdown
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.orderSummary,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildSummaryRow(
                          context,
                          l10n.subtotal,
                          '\$${subtotal.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          context,
                          l10n.deliveryFee,
                          '\$${deliveryFee.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 12),
                        Divider(color: colorScheme.outlineVariant),
                        const SizedBox(height: 8),
                        _buildSummaryRow(
                          context,
                          l10n.totalAmount,
                          '\$${grandTotal.toStringAsFixed(2)}',
                          isBold: true,
                          highlightColor: colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),

      // Sticky Bottom Checkout Bar
      bottomSheet: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) return const SizedBox.shrink();

          const double deliveryFee = 2.50;
          final double grandTotal = state.totalPrice + deliveryFee;

          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    _handleCheckout(context, grandTotal);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.placeOrderWithTotal(
                          '\$${grandTotal.toStringAsFixed(2)}',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Empty Cart View
  Widget _buildEmptyCart(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 72,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.yourCartIsEmpty,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.emptyCartMessage,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.restaurant_menu),
              label: Text(l10n.exploreMenu),
            ),
          ],
        ),
      ),
    );
  }

  // Helper row for Bill Summary
  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    Color? highlightColor,
  }) {
    final theme = Theme.of(context);
    final textStyle = isBold
        ? theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: highlightColor,
          )
        : theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: textStyle),
        Text(value, style: textStyle),
      ],
    );
  }

  // Clear Cart Confirmation Dialog
  void _showClearCartDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.clearCart),
        content: Text(l10n.clearCartConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: colorScheme.error),
            onPressed: () {
              context.read<CartBloc>().add(ClearCartEvent());
              Navigator.of(dialogContext).pop();
            },
            child: Text(l10n.clear),
          ),
        ],
      ),
    );
  }

void _handleCheckout(BuildContext context, double total) {
  final l10n = AppLocalizations.of(context)!;
  final cartState = context.read<CartBloc>().state;

  const double deliveryFee = 2.50;
  final order = Order(
    id: DateTime.now().millisecondsSinceEpoch.toString().substring(7),
    items: List.of(cartState.items),
    subtotal: cartState.totalPrice,
    deliveryFee: deliveryFee,
    total: total,
    paymentMethod: _selectedPaymentMethod == 'Cash on Delivery'
        ? l10n.cashOnDelivery
        : l10n.creditDebitCard,
    status: OrderStatus.pending,
    createdAt: DateTime.now(),
  );

  context.read<OrdersBloc>().add(PlaceOrderEvent(order));
  context.read<CartBloc>().add(ClearCartEvent());

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      content: Text(
        l10n.orderPlacedSuccessfully(order.paymentMethod),
      ),
    ),
  );
}
}

// ============================================================================
// REUSABLE CART ITEM TILE COMPONENT
// ============================================================================
class _CartItemTile extends StatelessWidget {
  final CartItem item;

  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.meal.thumbnail,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 70,
                  height: 70,
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(Icons.fastfood, color: colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Name & Price Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.meal.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.priceEach(
                      '\$${item.meal.price.toStringAsFixed(2)}',
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${item.totalPrice.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Quantity Adjustment Controls (+ / -)
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      item.quantity == 1 ? Icons.delete_outline : Icons.remove,
                      size: 18,
                      color: item.quantity == 1
                          ? colorScheme.error
                          : colorScheme.onSurface,
                    ),
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(RemoveFromCartEvent(item.meal.id));
                    },
                  ),
                  Text(
                    '${item.quantity}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () {
                      context.read<CartBloc>().add(AddToCartEvent(item.meal));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}