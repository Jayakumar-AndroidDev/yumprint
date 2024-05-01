import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/data_layer/repo/repository.dart';
import 'package:yumprint/presentation_layer/category_based_list_screen.dart/event/category_list_event.dart';
import 'package:yumprint/presentation_layer/category_based_list_screen.dart/state/category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent,CategoryListState>{
  Repository repository = Repository();
  CategoryListBloc():super(CategoryListInitialState()){
    on<CategoryListLoadEvent>((event,emit)async{
      try{
        emit(CategoryListLoadingState());
        final response = await repository.getCategoryList(event.selectedCategory);
        emit(CategoryListLoadedState(categoryListModel: response));
      }catch(e){
        emit(CategoryListErrorState(errorMessage: e.toString()));
      }
    });
  }
}