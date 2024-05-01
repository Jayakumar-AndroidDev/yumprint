import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/data_layer/repo/repository.dart';
import 'package:yumprint/presentation_layer/search_result_screen.dart/event/search_event.dart';
import 'package:yumprint/presentation_layer/search_result_screen.dart/state/search_state.dart';

class SearchResultBloc extends Bloc<SearchEvent, SearchState> {
  Repository repository = Repository();
  SearchResultBloc() : super(SearchInitialState()) {
    on<OnSearchSubmitClick>(
      (event, emit) async{
        try {
          emit(SearchLoadingState());
          final result = await repository.getSearchedList(event.searchMeal);
          emit(SearchLoadedState(popularMealModel: result));
        } catch (e) {
          emit(
            SearchErrorState(
              errorMessage: e.toString(),
            ),
          );
        }
      },
    );
  }
}
