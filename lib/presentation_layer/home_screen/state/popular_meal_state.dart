import 'package:equatable/equatable.dart';
import 'package:yumprint/data_layer/model/popular_meal_model.dart';

class PopularMealState extends Equatable{
 const PopularMealState();

  @override
  List<Object> get props => [];
}

class PopularMealIntialState extends PopularMealState{

}

class PopularMealLoadingState extends PopularMealState{

}

class PopularMealLoadedState extends PopularMealState{
  final PopularMealModel? popularMealModel;
  const PopularMealLoadedState(this.popularMealModel);
}

class PopuplarMealErrorState extends PopularMealState{
  final String? errorMessage;
  const PopuplarMealErrorState(this.errorMessage);
}