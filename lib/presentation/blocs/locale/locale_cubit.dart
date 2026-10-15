import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/services/locale_preferences_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Holds the app language (English by default) and remembers it.
class LocaleCubit extends Cubit<Locale> {
  static const Set<String> _supportedCodes = {'en', 'ar'};

  final LocalePreferencesService _preferences;

  LocaleCubit(this._preferences) : super(const Locale('en'));

  /// Called once at startup, before the first screen is drawn.
  Future<void> loadSavedLocale() async {
    final code = await _preferences.readLanguageCode();
    if (isClosed) return;
    if (code != null && _supportedCodes.contains(code)) {
      emit(Locale(code));
    }
  }

  void toggle() {
    final next =
        state.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    emit(next);
    unawaited(_preferences.saveLanguageCode(next.languageCode));
  }
}