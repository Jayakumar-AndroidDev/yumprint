import 'package:flutter/material.dart';
import 'package:yumprint/presentation_layer/bottom_navigation/ui/bottom_navigation_screen.dart';
import 'package:yumprint/presentation_layer/category_based_list_screen.dart/ui/category_based_list_screen.dart';
import 'package:yumprint/presentation_layer/edit_profile_screen/ui/edit_profile_screen.dart';
import 'package:yumprint/presentation_layer/meal_detail_screen/ui/meal_detail_screen.dart';
import 'package:yumprint/presentation_layer/network_observe/ui/networkfail_screen.dart';
import 'package:yumprint/presentation_layer/search_result_screen.dart/ui/search_result_screen.dart';
import 'package:yumprint/presentation_layer/video_player_screen/video_player_page.dart';

class NavigationRoute {
  static Route<dynamic> getGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return MaterialPageRoute(
            builder: (ctx) => const BottomNavigationScreen(),
          );
        }
      case 'edit_profile': 
      {
        return MaterialPageRoute(builder: (context) => EditProfileScreen(refreshData: () {
          
        },),);
      }  
      case 'meal_detail_screen':
        {
          final mealId = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => MealDetailScreen(
              mealId: mealId.toString(),
            ),
          );
        }
      case 'video_player_page':
        {
          final videoUrl = settings.arguments.toString();
          return MaterialPageRoute(
            builder: (context) => VideoPlayerPage(videoUrl: videoUrl),
          );
        }
      case 'category_meal_list':
        {
          final category = settings.arguments.toString();
          return MaterialPageRoute(
            builder: (context) => CategoryListScreen(categoryName: category),
          );
        }

      case '/network_screen':
        {
          return MaterialPageRoute(
            builder: (context) => const NetworkFailScreen(),
          );
        }

      case 'search_screen':
        {
          final mealName = settings.arguments.toString();
          return MaterialPageRoute(
            builder: (context) => SearchResultScreen(mealName: mealName),
          );
        }
      default:
        {
          return MaterialPageRoute(
            builder: (ctx) => const BottomNavigationScreen(),
          );
        }
    }
  }
}
