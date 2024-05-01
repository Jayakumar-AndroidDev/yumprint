import 'package:yumprint/data_layer/db/sqlite_db.dart';
import 'package:yumprint/data_layer/model/category_list_model.dart';
import 'package:yumprint/data_layer/model/category_model.dart';
import 'package:yumprint/data_layer/model/meal_detail_model.dart';
import 'package:yumprint/data_layer/model/popular_meal_model.dart';
import 'package:yumprint/data_layer/model/random_meal_model.dart';
import 'package:yumprint/data_layer/model/user_profile_model.dart';
import 'package:yumprint/data_layer/provider/api_provider.dart';

class Repository {
  
  final apiProvider = ApiProvider();

  Future<RandomMealModel> getRandomMealData(){
    return apiProvider.getMealModelRawData();
  }

  Future<PopularMealModel> getPopularMeals(){
    return apiProvider.getPopularMeal();
  }

  Future<CategoryModel> getCategory(){
    return apiProvider.getCategory();
  } 

  Future<MealDetailModel> getMealDetail(String mealId){
    return apiProvider.getMealDetail(mealId);
  }

  Future<CategoryListModel> getCategoryList(String category){
    return apiProvider.getCategoryList(category);
  }

  Future<RandomMealModel> getSearchedList(String searchedMeal){
    return apiProvider.getMealSearchList(searchedMeal);
  }

    Future<List<UserProfileModel>> getUserName() async {
    final list = await SqliteDb.sqliteDb.getListItem();

    return list;
  }
}

