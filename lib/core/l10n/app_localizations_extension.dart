import 'package:flutter/widgets.dart';
import 'package:flutter_app/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  String formatPrice(double value) {
    return '${l10n.currencySymbol}${value.toStringAsFixed(2)}';
  }
}
