import 'package:flutter/material.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navBrowse)),
      body: Center(child: Text(l10n.comingSoonMessage)),
    );
  }
}