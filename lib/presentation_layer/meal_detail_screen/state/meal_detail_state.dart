import 'package:yumprint/data_layer/model/meal_detail_model.dart';

class MealDetailState {

}

class MealDetailInitalState extends MealDetailState{

}

class MealDetailErrorState extends MealDetailState{
  String? errorMessage;
  MealDetailErrorState({this.errorMessage});
}

class MealDetailLoadingState extends MealDetailState{
}

class MealDetailLoadedState extends MealDetailState{
  MealDetailModel mealDetailModel;
  MealDetailLoadedState({required this.mealDetailModel});
}

