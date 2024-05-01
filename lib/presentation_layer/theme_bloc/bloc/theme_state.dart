part of 'theme_bloc.dart';

class ThemeState{

}

class LightThemeState extends ThemeState{
  final bool isLightThemeOn;
  LightThemeState({required this.isLightThemeOn});
}

class DarkThemeState extends ThemeState{
  final bool isDarkThemeOn;
  DarkThemeState({required this.isDarkThemeOn});
}
