import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yumprint/data_layer/model/category_list_model.dart';
import 'package:yumprint/data_layer/model/meal_detail_model.dart';
import 'package:yumprint/data_layer/model/popular_meal_model.dart';
import 'package:yumprint/data_layer/model/random_meal_model.dart';
import 'package:yumprint/data_layer/model/category_model.dart';

class ApiProvider {

  final baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  final popularMealBaseUrl = 'https://www.themealdb.com/api/json/v1/1/filter.php?';
  final categoryBaseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  Future<RandomMealModel> getMealModelRawData() async {
    final data = await http.get(Uri.parse('${baseUrl}random.php'));
    try {
      if (data.statusCode == 200) {
        final response = await json.decode(data.body);
        return RandomMealModel.fromJson(response);
      } else {
        return RandomMealModel.errorMessage("Unable to random meal");
      }
    } catch (e) {
      return RandomMealModel.errorMessage(e.toString());
    }
  }
  
  Future<PopularMealModel> getPopularMeal() async {
    final response = await http.get(Uri.parse('${popularMealBaseUrl}i=chicken_breast'));
    try{
      print('check_popular_meal: ${response.body} ${response.statusCode}');
      if(response.statusCode == 200){
        final jsonObj = await jsonDecode(response.body);
        
        return PopularMealModel.fromJson(jsonObj);
      }else{
        return PopularMealModel.errorMessage('Unable to fetch popular meal');
      }
    }catch(e){
      return PopularMealModel.errorMessage(e.toString());
    }
  }

  Future<CategoryModel> getCategory() async {
      final response = await http.get(Uri.parse('${categoryBaseUrl}categories.php'));
      try{
        if(response.statusCode == 200){
          final data = await json.decode(response.body);
          return CategoryModel.fromJson(data);
        }else{
          return CategoryModel.isError(true);
        }
      }catch(e){
          return CategoryModel.isError(true);
      }
  }

  Future<MealDetailModel> getMealDetail(String mealId) async {
    final response = await http.get(Uri.parse('${baseUrl}lookup.php?i=$mealId'));
    
    if(response.statusCode == 200){
      final data = await json.decode(response.body);
      print('meal_detail_check_api_api: $data');
      return MealDetailModel.fromJson(data);
    }else{
      return MealDetailModel.setErrorMessage('Unable to fetch data.');
    }
  }

  Future<CategoryListModel> getCategoryList(String category) async {
    final response = await http.get(Uri.parse('${baseUrl}filter.php?c=$category'));
    try{
      if(response.statusCode == 200){
        final data = await json.decode(response.body);
        return CategoryListModel.fromJson(data);
      }else{
        return CategoryListModel.errorMessage('Unable to fetch list');
      }
    }catch(e){
        return CategoryListModel.errorMessage(e.toString());
    }
  }

  Future<RandomMealModel> getMealSearchList(String mealName)async{
    final response = await http.get(Uri.parse('${baseUrl}search.php?s=$mealName'));
    try{  
      print('search_click_event ${response.body}');
      final searchedMeal =  await json.decode(response.body);
      return RandomMealModel.fromJson(searchedMeal);
    }catch(e){
      return RandomMealModel.errorMessage(e.toString());
    }
  }
}
