import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/data_layer/repo/repository.dart';
import 'package:yumprint/presentation_layer/home_screen/event/popular_meal_event.dart';
import 'package:yumprint/presentation_layer/home_screen/state/popular_meal_state.dart';

class PopularMealBloc extends Bloc<PopularMealEvent,PopularMealState>{
   final Repository repository = Repository();
   PopularMealBloc():super(PopularMealIntialState()){
     on<PopularMealEvent>((event, emit) async {
        try{
          emit(PopularMealLoadingState());
          final response = await repository.getPopularMeals();
          emit(PopularMealLoadedState(response));
        }catch(e){
          emit(PopuplarMealErrorState(e.toString()));
        }
     },);
   }
}