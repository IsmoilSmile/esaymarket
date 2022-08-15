import 'package:esaymarket/controllers/cart_controller.dart';
import 'package:esaymarket/pages/home_pages/main_food_page.dart';
import 'package:esaymarket/utils/app_constants.dart';
import 'package:esaymarket/utils/color.dart';
import 'package:esaymarket/utils/dimensions.dart';
import 'package:esaymarket/widgets_page/app_icon.dart';
import 'package:esaymarket/widgets_page/big_text.dart';
import 'package:esaymarket/widgets_page/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.arrow_back_ios,
                  iconColor: Colors.white,
                  backgroundColor: FoodColor.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(() => FoodPage());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: FoodColor.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: FoodColor.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController){
                  return ListView.builder(
                      itemCount: cartController.getItems.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: Dimensions.width20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              Container(
                                margin:
                                EdgeInsets.only(bottom: Dimensions.height10),
                                width: Dimensions.width20 * 5,
                                height: Dimensions.width20 * 5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(
                                          AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!
                                        ),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Expanded(
                                child: Container(
                                  height: Dimensions.height20 * 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                      SmallText(text: "Spicy",),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(text: cartController.getItems[index].price!.toString(), color: Colors.redAccent,),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: Dimensions.height10,
                                                bottom: Dimensions.height10,
                                                left: Dimensions.width10,
                                                right: Dimensions.width10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: (){
                                                    //popularProduct.setQuaantity(false);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: FoodColor.signColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width10 / 2,
                                                ),
                                                BigText(text: "0"),//popularProduct.inCartItems.toString()),
                                                SizedBox(
                                                  width: Dimensions.width10 / 2,
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    //popularProduct.setQuaantity(true);
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: FoodColor.signColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
