import 'package:flutter/material.dart';
import 'package:yumprint/presentation_layer/theme_bloc/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchWidget extends StatefulWidget {
  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool isEnable = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        late bool value;
        if(state is LightThemeState){
          value = state.isLightThemeOn;
        }
        if(state is DarkThemeState){
          value = state.isDarkThemeOn;
        }
        return Switch(
          value: value,
          activeColor: Colors.blue,

          onChanged: (value) {
            if (value == true) {
              BlocProvider.of<ThemeBloc>(context)
                  .add(SwitchOnEvent(isSwitchOn: value));
            }

            if (value == false) {
              BlocProvider.of<ThemeBloc>(context)
                  .add(SwitchOffEvent(isSwitchOff: value));
            }
          },
        );
      },
    );
  }
}
