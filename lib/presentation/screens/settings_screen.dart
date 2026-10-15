import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/widgets/language_toggle_button.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsLabel)),
      body: ListTile(
        leading: const Icon(Icons.language),
        title: Text(l10n.languageLabel),
        trailing: const LanguageToggleButton(),
      ),
    );
  }
}