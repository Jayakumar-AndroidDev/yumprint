import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/bottom_navigation/cubit/navigation_cubit.dart';
import 'package:yumprint/presentation_layer/bottom_navigation/state/selected_index_state.dart';
import 'package:yumprint/presentation_layer/home_screen/ui/home_screen.dart';
import 'package:yumprint/presentation_layer/network_observe/bloc/network_bloc.dart';
import 'package:yumprint/presentation_layer/network_observe/state/network_state.dart';
import 'package:yumprint/presentation_layer/network_observe/ui/networkfail_screen.dart';
import 'package:yumprint/presentation_layer/search_screen/ui/search_screen.dart';
import 'package:yumprint/presentation_layer/setting_page/ui/setting_page.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {

        if(state is NetworkInitialState){
          return const NetworkFailScreen();
        }

        if (state is NetworkSuccessState) {
          return BlocProvider<NavigationCubit>(
            create: (context) => NavigationCubit(),
            child: BlocBuilder<NavigationCubit, SelectedIndexState>(
              builder: (context, state) {
                return Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.all(5 ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BottomNavigationBar(
                        backgroundColor: const Color.fromARGB(255, 255, 153, 0),
                        items: const [
                          BottomNavigationBarItem(
                              icon: Icon(Icons.home), label: 'Home'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.search), label: 'Search'),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.settings), label: 'Setting'),
                        ],
                        selectedItemColor: Colors.white,
                        unselectedItemColor: Color.fromARGB(202, 100, 100, 100),
                        currentIndex: state.selectedIndex,
                        onTap: (value) {
                          BlocProvider.of<NavigationCubit>(context)
                              .onSelected(value);
                        },
                      ),
                    ),
                  ),
                  body: contentWidgetList()[state.selectedIndex],
                );
              },
            ),
          );
        }

        if (state is NetworkFailureState) {
          return const NetworkFailScreen();
        }

        return const Center(
          child: Text('Something went wrong.'),
        );
      },
    );
  }

  List<Widget> contentWidgetList() {
    return [const HomeScreen(), const SearchScreen(), const SettingPage()];
  }
}
