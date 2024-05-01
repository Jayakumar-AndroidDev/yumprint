class PopularMealModel {
  List<Meals>? meals;
  String? errorMessage;

  PopularMealModel({this.meals});

  PopularMealModel.fromJson(Map<String, dynamic> json) {
    meals = json['meals'] == null ? null : List.from(json['meals']).map((e) => Meals.fromJson(e)).toList();
  }

  PopularMealModel.errorMessage(String message){
    errorMessage = message;
  }
}

class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meals({this.strMeal, this.strMealThumb, this.idMeal});

  Meals.fromJson(Map<String, dynamic> json) {
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
  }
}
