import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:streetbite/core/l10n/app_localizations_extension.dart';
import 'package:streetbite/presentation/blocs/locale/locale_bloc.dart';
import 'package:streetbite/presentation/blocs/locale/locale_event.dart';
import 'package:streetbite/presentation/blocs/locale/locale_state.dart';

class LanguageToggleAction extends StatelessWidget {
  const LanguageToggleAction({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        final String label = state.isArabic ? 'ع' : 'EN';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: InkWell(
            onTap: () {
              context.read<LocaleBloc>().add(const ToggleLocaleEvent());
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.translate_rounded,
                    size: 16,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
