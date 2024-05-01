import 'package:yumprint/data_layer/model/random_meal_model.dart';

class SearchState {

}

class SearchInitialState extends SearchState{

}

class SearchLoadingState extends SearchState{

}

class SearchLoadedState extends SearchState{
  RandomMealModel popularMealModel;
  SearchLoadedState({required this.popularMealModel});
}

class SearchErrorState extends SearchState{
  String errorMessage;
  SearchErrorState({required this.errorMessage});
}