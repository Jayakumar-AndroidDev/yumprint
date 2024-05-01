part of 'theme_bloc.dart';

class ThemeEvent {
}

class SwitchOnEvent extends ThemeEvent{
  final bool isSwitchOn;
  SwitchOnEvent({required this.isSwitchOn});
}

class SwitchOffEvent extends ThemeEvent{
  final bool isSwitchOff;
  SwitchOffEvent({required this.isSwitchOff});
}