import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/category_based_list_screen.dart/bloc/category_list_bloc.dart';
import 'package:yumprint/presentation_layer/category_based_list_screen.dart/event/category_list_event.dart';
import 'package:yumprint/presentation_layer/category_based_list_screen.dart/state/category_list_state.dart';
import 'package:yumprint/presentation_layer/component/container_component.dart';
import 'package:yumprint/presentation_layer/component/loading_container.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider<CategoryListBloc>(
      create: (context) => CategoryListBloc()
        ..add(CategoryListLoadEvent(selectedCategory: categoryName)),
      child: Scaffold(
        
        appBar: AppBar(
          title: Text(
            categoryName,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, state) {
            if (state is CategoryListLoadingState) {
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LoadingContainer(
                        width: size.width,
                        height: size.height * 0.2,
                      ));
                },
              );
            }
            if (state is CategoryListErrorState) {
              print('loading_state');
              return Center(
                child: Text(state.errorMessage.toString()),
              );
            }
            if (state is CategoryListLoadedState) {
              print('loading_state');
              return ListView.builder(
                itemCount: state.categoryListModel.mealsList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ContainerComponent(
                        width: size.width,
                        height: size.height * 0.2,
                        mealImageUrl: state
                            .categoryListModel.mealsList![index].strMealThumb
                            .toString(),
                        mealTitle: state
                            .categoryListModel.mealsList![index].strMeal
                            .toString(),
                        mealId: state
                            .categoryListModel.mealsList![index].strMealId
                            .toString()),
                  );
                },
              );
            }
            return const Text('Somethink went wrong');
          },
        ),
      ),
    );
  }
}
