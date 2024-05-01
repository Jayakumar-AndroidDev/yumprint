import 'package:equatable/equatable.dart';
import 'package:yumprint/data_layer/model/random_meal_model.dart';

class RandomMealState extends Equatable {

  const RandomMealState();

  @override
  List<Object> get props => [];
}

class InitialState extends RandomMealState{

}

class LoadingState extends RandomMealState{

}

class LoadedState extends RandomMealState{
  final RandomMealModel? randomMealModel;
  const LoadedState({this.randomMealModel});
}

class ErrorState extends RandomMealState{
  final String? errorMessage;
  const ErrorState(this.errorMessage);
}