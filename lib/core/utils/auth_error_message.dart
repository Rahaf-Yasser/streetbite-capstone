import 'package:flutter_app/domain/entities/auth_exception.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

/// Turns an auth failure into the text shown in the UI. Firebase's own
/// message is shown for Firebase errors; everything else is a friendly,
/// translated message.
String authErrorMessage(
  AuthErrorType type,
  String? message,
  AppLocalizations l10n,
) {
  switch (type) {
    case AuthErrorType.firebase:
      return message ?? l10n.authUnknownError;
    case AuthErrorType.network:
      return l10n.authNetworkError;
    case AuthErrorType.unknown:
      return l10n.authUnknownError;
  }
}