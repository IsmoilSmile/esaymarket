import 'package:get/get.dart';

class Dimensions{

  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.89;
  static double pageViewTextContainer = screenHeight / 7.04;

  //height padding and margin
  static double height10 = screenHeight / 85.6;
  static double height20 = screenHeight / 42.8;
  static double height15  = screenHeight / 57;
  static double height30  = screenHeight / 28.5;
  static double height45  = screenHeight / 19;

  //width padding and margin
  static double width10 = screenHeight / 85.6;
  static double width20 = screenHeight / 42.8;
  static double width15  = screenHeight / 57;
  static double width30  = screenHeight / 28.5;

  //font size
  static double font16 = screenHeight / 53.5;
  static double font20 = screenHeight / 42.8;
  static double font26 = screenHeight / 32.9;

  //radius
  static double radius20 = screenHeight / 42.8;
  static double radius30 = screenHeight / 28.5;
  static double radius15 = screenHeight / 57;

  //Icon size
  static double iconSize24 = screenHeight / 35.6;
  static double iconSize16 = screenHeight / 53.5;

  //List view size
static double listViewIm = screenWidth / 3.25;
static double listViewTextContSize = screenWidth / 3.9;

//popular food
static double popularFoodImgSize = screenHeight / 2.41;

//bottom height
static double bottomHeightBar = screenHeight / 7.05;

}