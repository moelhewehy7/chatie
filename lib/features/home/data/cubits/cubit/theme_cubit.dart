import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightThemeState(Colors.indigo)) {
    getsharedpref();
  }
  Color color = Colors.indigo;

  void toggleTheme() async {
    final sharedprefs = await SharedPreferences.getInstance();
    if (state is LightThemeState) {
      emit(DarkThemeState(color));
    } else {
      emit(LightThemeState(color));
    }
    sharedprefs.setBool('theme', state is LightThemeState ? false : true);
  }

  void setColor(Color newColor) async {
    final sharedprefs = await SharedPreferences.getInstance();
    color = newColor; //updates the color variable with the new color.
    if (state is LightThemeState) {
      emit(LightThemeState(color)); // emits a new State with the new color.
    } else {
      emit(DarkThemeState(color));
    }
    sharedprefs.setInt("color", color.value);
  }

  getsharedpref() async {
    final sharedprefs = await SharedPreferences.getInstance();
    color = Color(sharedprefs.getInt("color") ?? Colors.indigo.value);
    if (sharedprefs.getBool('theme') == true) {
      emit(DarkThemeState(color));
    } else {
      emit(LightThemeState(color));
    }
  }
}
