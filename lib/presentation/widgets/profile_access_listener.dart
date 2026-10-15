import 'package:flutter/material.dart';
import 'package:flutter_app/core/utils/biometric_message.dart';
import 'package:flutter_app/injection.dart';
import 'package:flutter_app/presentation/blocs/biometric/biometric_cubit.dart';
import 'package:flutter_app/presentation/blocs/biometric/biometric_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

/// Single place that runs the fingerprint check before the Profile opens.
/// MainShell wraps the whole app area with it; the Profile tab and the
/// AppBar person icon both call [start] from below it.
class ProfileAccessListener extends StatelessWidget {
  final Widget child;
  final VoidCallback onUnlocked;

  const ProfileAccessListener({
    super.key,
    required this.child,
    required this.onUnlocked,
  });

  /// Starts the fingerprint check.
  static void start(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    context.read<BiometricCubit>().authenticate(l10n.biometricReason);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BiometricCubit>(
      create: (_) => getIt<BiometricCubit>(),
      child: BlocListener<BiometricCubit, BiometricState>(
        listener: (context, state) {
          if (state is BiometricSuccess) {
            onUnlocked();
          } else if (state is BiometricFailure) {
            final l10n = AppLocalizations.of(context)!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(biometricMessage(state.result, l10n))),
            );
          }
        },
        child: child,
      ),
    );
  }
}