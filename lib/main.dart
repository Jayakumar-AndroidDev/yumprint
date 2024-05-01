import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/data_layer/db/sqlite_db.dart';
import 'package:yumprint/navigation_route/navigation_route.dart';
import 'package:yumprint/presentation_layer/home_screen/bloc/category_bloc.dart';
import 'package:yumprint/presentation_layer/home_screen/bloc/popular_meal_bloc.dart';
import 'package:yumprint/presentation_layer/home_screen/bloc/random_meal_bloc.dart';
import 'package:yumprint/presentation_layer/home_screen/event/categroy_event.dart';
import 'package:yumprint/presentation_layer/home_screen/event/popular_meal_event.dart';
import 'package:yumprint/presentation_layer/home_screen/event/random_meal_event.dart';
import 'package:yumprint/presentation_layer/network_observe/bloc/network_bloc.dart';
import 'package:yumprint/presentation_layer/network_observe/event/network_event.dart';
import 'package:yumprint/presentation_layer/network_observe/state/network_state.dart';
import 'package:yumprint/presentation_layer/theme_bloc/bloc/theme_bloc.dart';

String path = '/';
void main() {

 

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CategoryBloc()..add(const CategoryEvent())),
        BlocProvider<RandomMealBloc>(
            create: (context) =>
                RandomMealBloc()..add(const RandomMealEvent())),
        BlocProvider<PopularMealBloc>(
            create: (context) =>
                PopularMealBloc()..add(const PopularMealEvent())),
        BlocProvider<NetworkBloc>(
            create: (context) => NetworkBloc()..add(NetworkObserveEvent())),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          late ThemeData themeData;
          if (state is LightThemeState) {
            themeData = ThemeData(
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.orange,
                primary: Colors.orange,
                background: Colors.white,
                surface: Colors.black,
              ),
            );
          }
          if (state is DarkThemeState) {
            themeData = ThemeData(
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.transparent),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.black,
                  primary: Colors.white,
                  background: const Color.fromARGB(255, 39, 39, 39),
                  surface: Colors.white),
            );
          }

          print('check_net_rebuild_1');

          print('rebuild: $path');

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeData,
            onGenerateRoute: NavigationRoute.getGeneratedRoute,
            initialRoute: path,
          );
        },
      ),
    ),
  );
}
