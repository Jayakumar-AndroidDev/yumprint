import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yumprint/presentation_layer/component/text_component.dart';
import 'package:yumprint/presentation_layer/meal_detail_screen/bloc/meal_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/meal_detail_screen/event/meal_detail_event.dart';
import 'package:yumprint/presentation_layer/meal_detail_screen/state/meal_detail_state.dart';

class MealDetailScreen extends StatefulWidget {
  const MealDetailScreen({super.key, required this.mealId});
  final String mealId;

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('check_meal-detail ${widget.mealId}');
    return BlocProvider<MealDetailBloc>(
      create: (context) =>
          MealDetailBloc(widget.mealId)..add(LoadMealDetailEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Meal Detail',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<MealDetailBloc, MealDetailState>(
          builder: (context, state) {
            if (state is MealDetailLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MealDetailErrorState) {
              return Center(
                child: Text(state.errorMessage.toString()),
              );
            }
            if (state is MealDetailLoadedState) {
              print('null_check_1');
              if (state.mealDetailModel.meals == null) {
                return Center(
                  child: Column(
                    children: [
                      Lottie.asset('image/404_error.json'),
                      const SizedBox(height: 10),
                      const Text('Something Went Wrong Please Try Again Later.')
                    ],
                  ),
                );
              }
              print('null_check_2');
              if (state.mealDetailModel.meals!.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Lottie.asset('image/404_error.json'),
                      const SizedBox(height: 10),
                      const Text('Something Went Wrong Please Try Again Later.')
                    ],
                  ),
                );
              }

              print('null_check_3');
              final stateData = state.mealDetailModel.meals![0];
              return SizedBox(
                width: size.width,
                height: size.height,
                child: Stack(
                  //fit: StackFit.expand,
                  children: [
                    FadeInImage.assetNetwork(
                      width: size.width,
                      height: size.height * 0.3,
                      placeholder: 'image/image_place_holder.png',
                      image: state.mealDetailModel.meals![0].strMealThumb
                          .toString(),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 0.7,
                      margin: const EdgeInsets.only(top: 210),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          //mainAxisSize: 100,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextComponent(
                                  text: state.mealDetailModel.meals![0].strMeal
                                      .toString(),
                                  textSize: 18,
                                  textColor:
                                      Theme.of(context).colorScheme.surface,
                                  fontWeight: FontWeight.bold,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        'video_player_page',
                                        arguments: stateData.strYoutube);
                                  },
                                  child: const Icon(
                                    Icons.play_circle,
                                    color: Colors.orange,
                                  ),
                                )
                              ],
                            ),
                            TabBar(
                              dividerColor: Colors.transparent,
                              indicatorColor: Colors.orange,
                              unselectedLabelColor:
                                  Theme.of(context).colorScheme.surface,
                              labelColor: Colors.orange,
                              tabs: const [
                                Tab(text: 'Ingredients'),
                                Tab(text: 'Instruction'),
                              ],
                              controller: _tabController,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  ingredientsWidget(
                                    stateData.strIngredient1.toString(),
                                    stateData.strIngredient2.toString(),
                                    stateData.strIngredient3.toString(),
                                    stateData.strIngredient4.toString(),
                                    stateData.strIngredient5.toString(),
                                    stateData.strIngredient6.toString(),
                                    stateData.strIngredient7.toString(),
                                    stateData.strIngredient8.toString(),
                                    stateData.strIngredient9.toString(),
                                    stateData.strMeasure1.toString(),
                                    stateData.strMeasure2.toString(),
                                    stateData.strMeasure3.toString(),
                                    stateData.strMeasure4.toString(),
                                    stateData.strMeasure5.toString(),
                                    stateData.strMeasure6.toString(),
                                    stateData.strMeasure7.toString(),
                                    stateData.strMeasure8.toString(),
                                    stateData.strMeasure9.toString(),
                                  ),
                                  instructionWidget(
                                      stateData.strInstructions.toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            print('null_check_4');
            return const Center(
              child: Text(''),
            );
          },
        ),
      ),
    );
  }

  Widget ingredientsWidget(
      String incredient1,
      String incredient2,
      String incredient3,
      String incredient4,
      String incredient5,
      String incredient6,
      String incredient7,
      String incredient8,
      String incredient9,
      String measure1,
      String measure2,
      String measure3,
      String measure4,
      String measure5,
      String measure6,
      String measure7,
      String measure8,
      String measure9) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  incredient1,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient2,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient3,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient4,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient5,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient6,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient7,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient8,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  incredient9,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ],
            )),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(
                measure1,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure2,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure3,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure4,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure5,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure6,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure7,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure8,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                measure9,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget instructionWidget(String instruction) {
    return SingleChildScrollView(
      child: Text(
        instruction,
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
