import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/domain/entities/order.dart';
import 'package:flutter_app/l10n/app_localizations.dart';
import 'package:flutter_app/presentation/blocs/orders/orders_bloc.dart';
import 'package:flutter_app/presentation/blocs/orders/order_event.dart';
import 'package:flutter_app/presentation/blocs/orders/order_state.dart';

class OrdersScreen extends StatelessWidget {
  
  const OrdersScreen({super.key, this.onStartOrdering});
  final VoidCallback? onStartOrdering;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          l10n.myOrders,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state.orders.isEmpty) {
            return _buildEmptyOrders(context);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return _OrderCard(order: order);
            },
          );
        },
      ),
    );
  }




  Widget _buildEmptyOrders(BuildContext context) {
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
                Icons.receipt_long_outlined,
                size: 72,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noOrdersYet,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noOrdersMessage,
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
              onPressed: onStartOrdering ??
                  () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.restaurant_menu),
              label: Text(l10n.startOrdering),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// ORDER CARD
// ============================================================================
class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  String _paymentLabel(AppLocalizations l10n, String key) =>
    key == 'cashOnDelivery' ? l10n.cashOnDelivery : l10n.creditDebitCard;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    final statusInfo = _statusInfo(context, order.status);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          shape: const Border(),
          collapsedShape: const Border(),
          iconColor: colorScheme.onSurfaceVariant,
          collapsedIconColor: colorScheme.onSurfaceVariant,
          title: Text(
            l10n.orderNumber(order.id),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusInfo.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusInfo.icon,
                        size: 14,
                        color: statusInfo.foreground,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        statusInfo.label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: statusInfo.foreground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _formatDate(context, order.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              Text(
                l10n.itemsCount(order.itemCount),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          children: [
            Divider(
              color: colorScheme.outlineVariant.withOpacity(0.5),
              thickness: 1,
            ),
            const SizedBox(height: 8),

            // Items
            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.meal.thumbnail,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 40,
                          height: 40,
                          color: colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.fastfood,
                            size: 20,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.meal.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      l10n.itemQuantity(item.quantity),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),
            Divider(
              color: colorScheme.outlineVariant.withOpacity(0.5),
              thickness: 1,
            ),
            const SizedBox(height: 8),

            _summaryRow(
              context,
              l10n.subtotal,
              '\$${order.subtotal.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 6),
            _summaryRow(
              context,
              l10n.deliveryFee,
              '\$${order.deliveryFee.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 6),
            _summaryRow(
              context,
              l10n.paymentMethod,
              _paymentLabel(l10n, order.paymentMethod),
            ),

            if (order.status == OrderStatus.pending ||
                order.status == OrderStatus.preparing) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(color: colorScheme.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.cancel_outlined),
                  label: Text(l10n.cancelOrder),
                  onPressed: () => _confirmCancel(context, order),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }


  Widget _summaryRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(date.day)}/${two(date.month)}/${date.year} '
        '${two(date.hour)}:${two(date.minute)}';
  }

  _StatusInfo _statusInfo(BuildContext context, OrderStatus status) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case OrderStatus.pending:
        return _StatusInfo(
          label: l10n.statusPending,
          icon: Icons.hourglass_empty,
          foreground: colorScheme.onTertiaryContainer,
          background: colorScheme.tertiaryContainer,
        );
      case OrderStatus.preparing:
        return _StatusInfo(
          label: l10n.statusPreparing,
          icon: Icons.restaurant,
          foreground: colorScheme.onSecondaryContainer,
          background: colorScheme.secondaryContainer,
        );
      case OrderStatus.onTheWay:
        return _StatusInfo(
          label: l10n.statusOnTheWay,
          icon: Icons.delivery_dining,
          foreground: colorScheme.onPrimaryContainer,
          background: colorScheme.primaryContainer,
        );
      case OrderStatus.delivered:
        return _StatusInfo(
          label: l10n.statusDelivered,
          icon: Icons.check_circle_outline,
          foreground: colorScheme.onSurface,
          background: colorScheme.surfaceContainerHighest,
        );
      case OrderStatus.cancelled:
        return _StatusInfo(
          label: l10n.statusCancelled,
          icon: Icons.cancel_outlined,
          foreground: colorScheme.onErrorContainer,
          background: colorScheme.errorContainer,
        );
    }
  }

  void _confirmCancel(BuildContext context, Order order) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.cancelOrder),
        content: Text(l10n.cancelOrderConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.no),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: colorScheme.error),
            onPressed: () {
              context.read<OrdersBloc>().add(CancelOrderEvent(order.id));
              Navigator.of(dialogContext).pop();
            },
            child: Text(l10n.yes),
          ),
        ],
      ),
    );
  }
}

class _StatusInfo {
  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;

  _StatusInfo({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.background,
  });
}