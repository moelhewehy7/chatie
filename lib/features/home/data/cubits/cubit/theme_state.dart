part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

class LightThemeState extends ThemeState {
  final ThemeData themeData;

  LightThemeState(Color pickedColor)
      : themeData = ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: pickedColor),
        );
}

class DarkThemeState extends ThemeState {
  final ThemeData themeData;

  DarkThemeState(Color pickedColor)
      : themeData = ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: pickedColor, brightness: Brightness.dark),
            useMaterial3: true);
}
//When you use : themeData = ..., you're initializing the themeData instance variable directly with a value,
// similar to how you might set a variable outside of a constructor in other parts of your code.