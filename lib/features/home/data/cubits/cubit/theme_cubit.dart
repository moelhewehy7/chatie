import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightThemeState(Colors.indigo));
  Color color = Colors.indigo;
  void toggleTheme() {
    if (state is LightThemeState) {
      emit(DarkThemeState(color));
    } else {
      emit(LightThemeState(color));
    }
  }

  void setColor(Color newColor) {
    color = newColor; //updates the color variable with the new color.
    if (state is LightThemeState) {
      emit(LightThemeState(color)); // emits a new State with the new color.
    } else {
      emit(DarkThemeState(color));
    }
  }
}
