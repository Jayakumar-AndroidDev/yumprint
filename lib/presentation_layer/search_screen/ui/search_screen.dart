import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/component/container_component.dart';
import 'package:yumprint/presentation_layer/component/text_component.dart';
import 'package:yumprint/presentation_layer/home_screen/bloc/category_bloc.dart';
import 'package:yumprint/presentation_layer/home_screen/state/category_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextComponent(
                  text: 'Search',
                  textSize: 30,
                  textColor: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      label: Text(
                        "Search like 'fish,chicken...'",
                        style: TextStyle(color: Colors.orange),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.orange,
                      )),
                  onSubmitted: (value) {
                    Navigator.pushNamed(context, 'search_screen',
                        arguments: value.toString());
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextComponent(
                  text: 'Popular Category',
                  textSize: 20,
                  textColor: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoadingState) {
                      return const Center(
                        child: Text('Loading...'),
                      );
                    }
                    if (state is CategoryErrorState) {
                      if (state.isError == true) {
                        return const Center(
                          child: Text('Unable to fetch data'),
                        );
                      }
                    }
                    if (state is CategoryLoadedState) {
                      return GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 5,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        children: [
                          ...List.generate(
                            state.categoryModel!.categories!.length,
                            (index) {
                              return ContainerComponent(
                                width: 150,
                                height: 150,
                                mealImageUrl: state.categoryModel!
                                    .categories![index].strCategoryThumb
                                    .toString(),
                                mealTitle: state.categoryModel!
                                    .categories![index].strCategory
                                    .toString(),
                                mealId: state.categoryModel!.categories![index]
                                    .idCategory
                                    .toString(),
                                isFromSearchCategory: true,
                              );
                            },
                          )
                        ],
                      );
                    }
                    return const Text('');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
