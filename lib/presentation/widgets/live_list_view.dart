import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/blocs/live_list/live_list_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Shared loading / error / empty / list display for live Firestore lists.
class LiveListView<T> extends StatelessWidget {
  final LiveListState<T> state;
  final VoidCallback onRetry;
  final String emptyMessage;
  final Widget Function(T item) itemBuilder;

  const LiveListView({
    super.key,
    required this.state,
    required this.onRetry,
    required this.emptyMessage,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    switch (state.status) {
      case LiveListStatus.loading:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: CircularProgressIndicator()),
        );

      case LiveListStatus.failure:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.sectionLoadError,
              style: theme.textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: onRetry,
              child: Text(l10n.retryButton),
            ),
          ],
        );

      case LiveListStatus.loaded:
        if (state.items.isEmpty) {
          return Text(
            emptyMessage,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          );
        }

        return Column(
          children: state.items.map(itemBuilder).toList(),
        );
    }
  }
}
