import 'package:flutter_app/domain/entities/biometric_result.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String biometricMessage(BiometricResult result, AppLocalizations l10n) {
  switch (result) {
    case BiometricResult.failed:
      return l10n.biometricFailed;
    case BiometricResult.notAvailable:
      return l10n.biometricNotAvailable;
    case BiometricResult.notEnrolled:
      return l10n.biometricNotEnrolled;
    case BiometricResult.lockedOut:
      return l10n.biometricLockedOut;
    case BiometricResult.error:
    case BiometricResult.success:
      return l10n.biometricError;
  }
}