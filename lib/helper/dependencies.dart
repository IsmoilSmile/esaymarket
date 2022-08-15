import 'package:esaymarket/controllers/cart_controller.dart';
import 'package:esaymarket/data/api/api_client.dart';
import 'package:esaymarket/data/api/repostory/popular_product_repo.dart';
import 'package:get/get.dart';
import '../controllers/popular_produtc_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../data/api/repostory/cart_repo.dart';
import '../data/api/repostory/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async{
  //Api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  //Controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}