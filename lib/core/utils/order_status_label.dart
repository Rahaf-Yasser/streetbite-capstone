import 'package:flutter_app/l10n/app_localizations.dart';

/// Turns the status stored in Firestore into a localized label.
/// An unknown status is shown as it is stored.
String orderStatusLabel(String status, AppLocalizations l10n) {
  switch (status) {
    case 'pending':
      return l10n.statusPending;
    case 'preparing':
      return l10n.statusPreparing;
    case 'onTheWay':
      return l10n.statusOnTheWay;
    case 'delivered':
      return l10n.statusDelivered;
    case 'cancelled':
      return l10n.statusCancelled;
    default:
      return status;
  }
}