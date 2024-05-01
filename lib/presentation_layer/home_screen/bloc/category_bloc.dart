import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/data_layer/repo/repository.dart';
import 'package:yumprint/presentation_layer/home_screen/event/categroy_event.dart';
import 'package:yumprint/presentation_layer/home_screen/state/category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  Repository repository = Repository();
  CategoryBloc():super(CategoryInitialState()){
    on<CategoryEvent>((event, emit) async {
      try{
        emit(CategoryLoadingState());
        final response = await repository.getCategory();
        emit(CategoryLoadedState(categoryModel: response));
      }catch(e){
        emit(CategoryErrorState(isError: true));
      }
    },);
  }
}