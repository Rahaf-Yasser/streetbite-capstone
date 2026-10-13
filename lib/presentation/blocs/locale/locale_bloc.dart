import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:streetbite/core/constants/api_constants.dart';
import 'package:streetbite/presentation/blocs/locale/locale_event.dart';
import 'package:streetbite/presentation/blocs/locale/locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  static const String _englishCode = 'en';
  static const String _arabicCode = 'ar';

  final SharedPreferences sharedPreferences;

  LocaleBloc({required this.sharedPreferences})
      : super(const LocaleState()) {
    on<ToggleLocaleEvent>(_onToggle);
    on<ChangeLocaleEvent>(_onChange);
  }

  Future<void> loadSavedLocale() async {
    final String? saved =
        sharedPreferences.getString(StorageKeys.selectedLanguage);
    if (saved != null && saved.isNotEmpty) {
      emit(state.copyWith(locale: Locale(saved)));
    }
  }

  void _onToggle(ToggleLocaleEvent event, Emitter<LocaleState> emit) {
    final String next =
        state.isArabic ? _englishCode : _arabicCode;
    _persist(next);
    emit(state.copyWith(locale: Locale(next)));
  }

  void _onChange(ChangeLocaleEvent event, Emitter<LocaleState> emit) {
    final String code = event.languageCode;
    if (code != _englishCode && code != _arabicCode) return;
    _persist(code);
    emit(state.copyWith(locale: Locale(code)));
  }

  void _persist(String languageCode) {
    sharedPreferences.setString(
      StorageKeys.selectedLanguage,
      languageCode,
    );
  }
}
