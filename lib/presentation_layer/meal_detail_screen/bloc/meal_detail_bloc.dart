import 'package:yumprint/data_layer/repo/repository.dart';
import 'package:yumprint/presentation_layer/meal_detail_screen/event/meal_detail_event.dart';
import 'package:yumprint/presentation_layer/meal_detail_screen/state/meal_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealDetailBloc extends Bloc<MealDetailEvent,MealDetailState>{
  final repository = Repository();
  MealDetailBloc(String mealId):super(MealDetailInitalState()){
    on<LoadMealDetailEvent>((event,emit)async{
      try{
        print('meal_detail_check_api: $mealId}');
        emit(MealDetailLoadingState());
        final response = await repository.getMealDetail(mealId);
        emit(MealDetailLoadedState(mealDetailModel: response));
      }catch(e){
        emit(MealDetailErrorState(errorMessage: e.toString()));
      }
    });
  }
}