class CategoryListModel {
  List<MealsList>? mealsList;
  String? errorMessage;
  CategoryListModel.fromJson(Map<String,dynamic> json){
    mealsList = json['meals'] == null ? null : List.from(json['meals']).map((e) => MealsList.fromJson(e)).toList();
  }
  CategoryListModel.errorMessage(String errorMessage){
    this.errorMessage = errorMessage;
  }
}

class MealsList{
  String? strMeal;
  String? strMealThumb;
  String? strMealId;
  
  MealsList.fromJson(Map<String,dynamic> json){
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    strMealId = json['idMeal'];
  }
}