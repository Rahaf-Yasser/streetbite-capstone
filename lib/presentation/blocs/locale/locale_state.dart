import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocaleState extends Equatable {
  final Locale? locale;

  const LocaleState({this.locale});

  bool get isArabic => locale?.languageCode == 'ar';
  bool get isEnglish => locale?.languageCode == 'en';
  bool get isManual => locale != null;

  LocaleState copyWith({Locale? locale}) {
    return LocaleState(locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];
}
