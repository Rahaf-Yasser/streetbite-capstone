import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:streetbite/core/l10n/app_localizations_extension.dart';
import 'package:streetbite/presentation/blocs/locale/locale_bloc.dart';
import 'package:streetbite/presentation/blocs/locale/locale_event.dart';
import 'package:streetbite/presentation/blocs/locale/locale_state.dart';

Future<void> showLocalePicker(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return BlocProvider.value(
        value: BlocProvider.of<LocaleBloc>(context),
        child: const _LocalePickerSheet(),
      );
    },
  );
}

class _LocalePickerSheet extends StatelessWidget {
  const _LocalePickerSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.selectLanguage,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, state) {
              return Column(
                children: [
                  _LocaleOptionTile(
                    title: l10n.english,
                    subtitle: 'English',
                    languageCode: 'en',
                    isSelected: state.isEnglish,
                  ),
                  const SizedBox(height: 8),
                  _LocaleOptionTile(
                    title: l10n.arabic,
                    subtitle: 'العربية',
                    languageCode: 'ar',
                    isSelected: state.isArabic,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LocaleOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String languageCode;
  final bool isSelected;

  const _LocaleOptionTile({
    required this.title,
    required this.subtitle,
    required this.languageCode,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: isSelected
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          context.read<LocaleBloc>().add(ChangeLocaleEvent(languageCode));
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
