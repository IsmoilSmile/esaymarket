import 'package:esaymarket/controllers/cart_controller.dart';
import 'package:esaymarket/controllers/popular_produtc_controller.dart';
import 'package:esaymarket/pages/cart/cart_page.dart';
import 'package:esaymarket/pages/home_pages/main_food_page.dart';
import 'package:esaymarket/utils/app_constants.dart';
import 'package:esaymarket/utils/dimensions.dart';
import 'package:esaymarket/widgets_page/app_column.dart';
import 'package:esaymarket/widgets_page/app_icon.dart';
import 'package:esaymarket/widgets_page/exandble_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/color.dart';
import '../../widgets_page/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  const PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                  AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!
                ),
                fit: BoxFit.fill,
              )),
            ),
          ),
          //Icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.to(() => FoodPage());
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<PopularProductController>(builder: (controller){
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get.find<PopularProductController>().totalItems >= 1?
                      Positioned(
                         right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: (){
                            Get.to(() => CartPage());
                          },
                          child: AppIcon(icon: Icons.circle, size: 20, iconColor: Colors.transparent,
                          backgroundColor: FoodColor.mainColor,),
                        ),
                      ):
                      Container(),
                      Get.find<PopularProductController>().totalItems >= 1?
                      Positioned(
                        right: 3,
                        top: 3,
                        child: Center(
                          child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                          size: 12, color: Colors.white,),
                        ),
                      ):
                      Container(),
                    ],
                  );
                }),
              ],
            ),
          ),
          //Introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize - 20,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text: product.name!,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(text: "Introduce"),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                        child: ExpandbleTextWidget(
                      text: product.description!)),
                  )
                ],
              ),
            ),
          ),
          //Expandable text widget
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProduct){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
            color: FoodColor.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuaantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: FoodColor.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    GestureDetector(
                      onTap: (){
                        popularProduct.setQuaantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: FoodColor.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                    child: BigText(
                      text: "\$ ${product.price!} | Add to cart",
                      color: Colors.white,
                    ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: FoodColor.mainColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
