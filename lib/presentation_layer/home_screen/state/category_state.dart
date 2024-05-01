import 'package:equatable/equatable.dart';
import 'package:yumprint/data_layer/model/category_model.dart';

class CategoryState extends Equatable{
  @override
  List<Object> get props => [];
}

class CategoryInitialState extends CategoryState{

}

class CategoryLoadingState extends CategoryState{
  
}

class CategoryErrorState extends CategoryState{
  final bool? isError;
  CategoryErrorState({required this.isError});
}

class CategoryLoadedState extends CategoryState{
  final CategoryModel? categoryModel;
  CategoryLoadedState({required this.categoryModel});
}