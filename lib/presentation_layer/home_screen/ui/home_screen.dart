import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/component/container_component.dart';
import 'package:yumprint/presentation_layer/component/loading_container.dart';
import 'package:yumprint/presentation_layer/component/text_component.dart';
import 'package:yumprint/presentation_layer/home_screen/bloc/category_bloc.dart';
import 'package:yumprint/presentation_layer/home_screen/bloc/popular_meal_bloc.dart';
import 'package:yumprint/presentation_layer/home_screen/bloc/random_meal_bloc.dart';
import 'package:yumprint/presentation_layer/home_screen/state/category_state.dart';
import 'package:yumprint/presentation_layer/home_screen/state/popular_meal_state.dart';
import 'package:yumprint/presentation_layer/home_screen/state/random_meal_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  text: "Home",
                  textSize: 30,
                  textColor: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                TextComponent(
                  text: "Good Food! Good Mood!",
                  textSize: 25,
                  textColor: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<RandomMealBloc, RandomMealState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      print('state_LoadingState');
                      return LoadingContainer(
                        width: size.width,
                        height: size.height * 0.2,
                      );
                    }
                    if (state is ErrorState) {
                      print('state_ErrorState');
                      return Text(state.errorMessage.toString());
                    }
                    if (state is LoadedState) {
                      print('state_LoadedState');
                      if (state.randomMealModel?.meals == null) {
                        return const Text('meal is null');
                      }
                      return ContainerComponent(
                        width: size.width,
                        height: size.height * 0.2,
                        mealImageUrl: state
                            .randomMealModel!.meals![0].strMealThumb
                            .toString(),
                        mealTitle:
                            state.randomMealModel!.meals![0].strMeal.toString(),
                        mealId:
                            state.randomMealModel!.meals![0].idMeal.toString(),
                      );
                    }
                    return const Text('Somethink went wrong!');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextComponent(
                  text: "Over Popular Items",
                  textSize: 25,
                  textColor: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                BlocBuilder<PopularMealBloc, PopularMealState>(
                  builder: (context, state) {
                    if (state is PopularMealLoadingState) {
                      return SizedBox(
                        width: size.width,
                        height: size.height * 0.2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:EdgeInsets.only(left: index == 0 ? 0.0 : 8.0),
                              child: LoadingContainer(
                                width: size.width * 0.3,
                                height: size.height * 0.2,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    if (state is PopuplarMealErrorState) {
                      return Text(state.errorMessage.toString());
                    }
                    if (state is PopularMealLoadedState) {
                      if (state.popularMealModel == null) {
                        return const Text('model empty...');
                      }
                      if (state.popularMealModel!.meals == null) {
                        return const Text('meal empty...');
                      }
                      if (state.popularMealModel!.meals!.isEmpty) {
                        return const Text('empty...');
                      }
                      return SizedBox(
                        width: size.width,
                        height: size.height * 0.2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.popularMealModel?.meals?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 0.0 : 8.0),
                              child: ContainerComponent(
                                width: size.width * 0.3,
                                height: size.height * 0.2,
                                mealImageUrl: state.popularMealModel!
                                    .meals![index].strMealThumb
                                    .toString(),
                                mealTitle: state
                                    .popularMealModel!.meals![index].strMeal
                                    .toString(),
                                mealId: state
                                    .popularMealModel!.meals![index].idMeal
                                    .toString(),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextComponent(
                  text: "Category",
                  textSize: 25,
                  textColor: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    boxShadow:  [BoxShadow(color: Color.fromARGB(255, 141, 141, 141), blurRadius: 5)],
                  ),
                  child: Card(
                    elevation: 3,
                    
                    color: Theme.of(context).colorScheme.background,
                    surfaceTintColor: Colors.white,
                    child: Column(
                      children: [
                        BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            if (state is CategoryLoadingState) {
                              return LoadingContainer(
                                width: size.width,
                                height: size.height * 0.3
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
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth <= 450) {
                                    return gridViewForSmallScreen(
                                        context, size, state);
                                  } else {
                                    return gridViewForLargeScreen(
                                        context, size, state);
                                  }
                                },
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridViewForLargeScreen(
      BuildContext context, Size size, CategoryLoadedState state) {
    return SizedBox(
      width: size.width,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          ...List.generate(
            state.categoryModel!.categories!.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('category_meal_list',
                      arguments: state
                          .categoryModel!.categories![index].strCategory
                          .toString());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: 'image/image_place_holder.png',
                      image: state
                          .categoryModel!.categories![index].strCategoryThumb
                          .toString(),
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      state.categoryModel!.categories![index].strCategory.toString(),
                      style: TextStyle(color: Theme.of(context).colorScheme.surface),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget gridViewForSmallScreen(
      BuildContext context, Size size, CategoryLoadedState state) {
    return SizedBox(
      width: size.width,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          ...List.generate(
            state.categoryModel!.categories!.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('category_meal_list',
                      arguments: state
                          .categoryModel!.categories![index].strCategory
                          .toString());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInImage.assetNetwork(
                      placeholder: 'image/image_place_holder.png',
                      image: state
                          .categoryModel!.categories![index].strCategoryThumb
                          .toString(),
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      state.categoryModel!.categories![index].strCategory.toString(),
                      style: TextStyle(color: Theme.of(context).colorScheme.surface),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
