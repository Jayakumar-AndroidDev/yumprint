import 'package:yumprint/data_layer/repo/repository.dart';
import 'package:yumprint/presentation_layer/home_screen/event/random_meal_event.dart';
import 'package:yumprint/presentation_layer/home_screen/state/random_meal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomMealBloc extends Bloc<RandomMealEvent, RandomMealState> {
  RandomMealBloc() : super(InitialState()) {
    Repository repositoryProvider = Repository();
    on<RandomMealEvent>(
      (event, emit) async {
        
        try{
          emit(LoadingState());
          final reponseData = await repositoryProvider.getRandomMealData();
          emit(LoadedState(randomMealModel:reponseData));
        }catch(e){
          emit(ErrorState(e.toString()));
        }
      },
    );
  }
}
