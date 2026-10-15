import 'package:flutter/material.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

Future<void> showComingSoonDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      content: Text(l10n.comingSoonMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(l10n.okButton),
        ),
      ],
    ),
  );
}