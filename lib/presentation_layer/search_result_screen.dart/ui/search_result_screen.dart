import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/component/container_component.dart';
import 'package:yumprint/presentation_layer/search_result_screen.dart/bloc/search_result_bloc.dart';
import 'package:yumprint/presentation_layer/search_result_screen.dart/event/search_event.dart';
import 'package:yumprint/presentation_layer/search_result_screen.dart/state/search_state.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key, required this.mealName});
  final String mealName;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Result',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
        create: (context) =>
            SearchResultBloc()..add(OnSearchSubmitClick(searchMeal: mealName)),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: BlocBuilder<SearchResultBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SearchErrorState) {
                return Center(
                  child: Text(state.errorMessage.toString()),
                );
              }
              if (state is SearchLoadedState) {
                return ListView.builder(
                  itemCount: state.popularMealModel.meals!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ContainerComponent(
                        width: size.width,
                        height: size.height * 0.15,
                        mealImageUrl: state
                            .popularMealModel.meals![index].strMealThumb
                            .toString(),
                        mealTitle: state.popularMealModel.meals![index].strMeal
                            .toString(),
                        mealId: state.popularMealModel.meals![index].idMeal
                            .toString(),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
