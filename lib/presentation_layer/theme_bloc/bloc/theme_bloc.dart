import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightThemeState(isLightThemeOn: false)) {
    on<SwitchOnEvent>(
      (event, emit) {
        emit(DarkThemeState(
          isDarkThemeOn: event.isSwitchOn,
        ));
      },
    );
    on<SwitchOffEvent>(
      (event, emit) {
        emit(
          LightThemeState(
            isLightThemeOn: event.isSwitchOff,
          ),
        );
      },
    );
  }
}
