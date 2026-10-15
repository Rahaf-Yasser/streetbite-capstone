import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Turns the status stored in Firestore into a localized label.
/// An unknown status is shown as it is stored.
String orderStatusLabel(String status, AppLocalizations l10n) {
  switch (status) {
    case 'pending':
      return l10n.orderStatusPending;
    case 'delivered':
      return l10n.orderStatusDelivered;
    case 'cancelled':
      return l10n.orderStatusCancelled;
    default:
      return status;
  }
}