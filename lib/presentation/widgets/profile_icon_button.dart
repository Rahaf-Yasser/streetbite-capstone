import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/widgets/profile_access_listener.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

/// AppBar action that starts the fingerprint check.
/// It must be used below a [ProfileAccessListener] (MainShell provides it).
class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person_outline),
      tooltip: AppLocalizations.of(context)!.profileTooltip,
      onPressed: () => ProfileAccessListener.start(context),
    );
  }
}