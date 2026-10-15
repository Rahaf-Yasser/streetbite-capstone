import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/order_status_label.dart';
import 'package:flutter_app/domain/entities/order_entity.dart';
import 'package:flutter_app/presentation/blocs/live_list/live_list_state.dart';
import 'package:flutter_app/presentation/blocs/order_history/order_history_cubit.dart';
import 'package:flutter_app/presentation/widgets/live_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderHistorySection extends StatelessWidget {
  const OrderHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dates = MaterialLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.orderHistoryTitle,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        BlocBuilder<OrderHistoryCubit, LiveListState<OrderEntity>>(
          builder: (context, state) => LiveListView<OrderEntity>(
            state: state,
            onRetry: () => context.read<OrderHistoryCubit>().load(),
            emptyMessage: l10n.noOrders,
            itemBuilder: (order) {
              final parts = [
                if (order.createdAt != null)
                  dates.formatShortDate(order.createdAt!),
                orderStatusLabel(order.status, l10n),
              ];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.receipt_long_outlined),
                title: Text(order.restaurantName),
                subtitle: Text(parts.join(' · ')),
                trailing: Text(
                  l10n.orderTotal(order.total.toStringAsFixed(2)),
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}