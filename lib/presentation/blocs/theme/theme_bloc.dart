import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:streetbite/presentation/blocs/theme/theme_event.dart';
import 'package:streetbite/presentation/blocs/theme/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc({ThemeMode initialMode = ThemeMode.system})
      : super(ThemeState(themeMode: initialMode)) {
    on<ToggleThemeEvent>(_onToggle);
  }

  void _onToggle(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: nextThemeMode(state.themeMode)));
  }
}
