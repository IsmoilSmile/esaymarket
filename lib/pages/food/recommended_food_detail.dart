import 'package:esaymarket/controllers/popular_produtc_controller.dart';
import 'package:esaymarket/controllers/recommended_product_controller.dart';
import 'package:esaymarket/pages/cart/cart_page.dart';
import 'package:esaymarket/routes/route_helper.dart';
import 'package:esaymarket/utils/app_constants.dart';
import 'package:esaymarket/utils/color.dart';
import 'package:esaymarket/utils/dimensions.dart';
import 'package:esaymarket/widgets_page/app_icon.dart';
import 'package:esaymarket/widgets_page/big_text.dart';
import 'package:esaymarket/widgets_page/exandble_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;

  const RecommendedFoodDetail({Key? key, required this.pageId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 90,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear)),
                //AppIcon(icon: Icons.shopping_cart_outlined),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => CartPage());
                                },
                                child: AppIcon(
                                  icon: Icons.circle,
                                  size: 20,
                                  iconColor: Colors.transparent,
                                  backgroundColor: FoodColor.mainColor,
                                ),
                              ),
                            )
                          : Container(),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? Positioned(
                              right: 3,
                              top: 3,
                              child: Center(
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  );
                }),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(
                        Dimensions.radius20,
                      ),
                      topLeft: Radius.circular(
                        Dimensions.radius20,
                      ),
                    ),
                  ),
                  child: Center(
                      child: BigText(
                    size: Dimensions.font26,
                    text: product.name!,
                  ))),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                fit: BoxFit.fill,
                width: double.maxFinite,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                child: ExpandbleTextWidget(text: product.description!),
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
              ),
            ],
          )),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuaantity(false);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        icon: Icons.remove,
                        backgroundColor: FoodColor.mainColor,
                      ),
                    ),
                    BigText(
                      text: "\$ ${product.price!} X ${controller.inCartItems}",
                      color: FoodColor.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuaantity(true);
                      },
                      child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white,
                        icon: Icons.add,
                        backgroundColor: FoodColor.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      height: 80,
                      width: 65,
                      child: AppIcon(
                        icon: Icons.favorite,
                        iconColor: FoodColor.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: FoodColor.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
