import 'package:esaymarket/pages/food/recommended_food_detail.dart';
import 'package:esaymarket/pages/home_pages/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../pages/food/popular_food.dart';

class RouteHelper {
  static const String initial = "/";

  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => "$initial";

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';

  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => FoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetail(
            pageId: int.parse(pageId!),
          );
        },
        transition: Transition.circularReveal),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetail(
            pageId: int.parse(pageId!),
          );
        },
        transition: Transition.circularReveal),
  ];
}
