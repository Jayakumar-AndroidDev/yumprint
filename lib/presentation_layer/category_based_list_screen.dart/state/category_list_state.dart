import 'package:yumprint/data_layer/model/category_list_model.dart';

class CategoryListState {

}

class CategoryListInitialState extends CategoryListState{

}

class CategoryListLoadingState extends CategoryListState{
  
}

class CategoryListErrorState extends CategoryListState{
  String errorMessage;
  CategoryListErrorState({required this.errorMessage});
}

class CategoryListLoadedState extends CategoryListState{
  CategoryListModel categoryListModel;
  CategoryListLoadedState({required this.categoryListModel});
}

