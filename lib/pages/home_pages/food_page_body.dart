import 'package:dots_indicator/dots_indicator.dart';
import 'package:esaymarket/controllers/popular_produtc_controller.dart';
import 'package:esaymarket/controllers/recommended_product_controller.dart';
import 'package:esaymarket/models/product_models.dart';
import 'package:esaymarket/pages/food/popular_food.dart';
import 'package:esaymarket/routes/route_helper.dart';
import 'package:esaymarket/utils/app_constants.dart';
import 'package:esaymarket/utils/color.dart';
import 'package:esaymarket/utils/dimensions.dart';
import 'package:esaymarket/widgets_page/app_column.dart';
import 'package:esaymarket/widgets_page/big_text.dart';
import 'package:esaymarket/widgets_page/icon_and_text_widget.dart';
import 'package:esaymarket/widgets_page/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isLoaded?Container(
            height: Dimensions.pageView,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: popularProducts.popularProductList.length,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position, popularProducts.popularProductList[position]);
                  }),

          )
              :CircularProgressIndicator(
            color: FoodColor.mainColor,
          );
        }),
        //dotsIndicator
        GetBuilder<PopularProductController>(builder: (popularProduct){


            return DotsIndicator(
              dotsCount: popularProduct.popularProductList.length <= 0? 1 : popularProduct.popularProductList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                size:  Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeColor: FoodColor.mainColor,
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );

        }),
        //popular text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                ),
              ),
            ],
          ),
        ),
        //recommended food
        //List food and image
         GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
           return recommendedProduct.isLoaded ?ListView.builder(
             physics: const NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: recommendedProduct.recommendedProductList.length,
             itemBuilder: (context, index) {
               return GestureDetector(
                 onTap: (){
                   Get.toNamed(RouteHelper.getRecommendedFood(index));
                 },
                 child: Container(
                   margin: EdgeInsets.only(
                       left: Dimensions.width20,
                       right: Dimensions.width20,
                       bottom: Dimensions.height10),
                   child: Row(
                     children: [
                       //Image container
                       Container(
                         width: Dimensions.listViewIm,
                         height: Dimensions.listViewIm,
                         decoration: BoxDecoration(
                           borderRadius:
                           BorderRadius.circular(Dimensions.radius20),
                           color: Colors.white38,
                           image: DecorationImage(
                             image: NetworkImage(
                                 AppConstants.BASE_URL + AppConstants.UPLOAD_URL + recommendedProduct.recommendedProductList[index].img!
                             ),
                             fit: BoxFit.fill,
                           ),
                         ),
                       ),
                       //Text container
                       Expanded(
                         child: Container(
                           height: Dimensions.listViewTextContSize,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.only(
                               topRight: Radius.circular(
                                 Dimensions.radius20,
                               ),
                               bottomRight: Radius.circular(
                                 Dimensions.radius20,
                               ),
                             ),
                             color: Colors.white,
                           ),
                           child: Padding(
                             padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                             child: AppColumn(text: recommendedProduct.recommendedProductList[index].name!),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               );
             },
           ) : CircularProgressIndicator(
             color: FoodColor.mainColor,
           );

         }),

      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProducts) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(8, 8),
                  ),
                ],
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  image: NetworkImage(
                    AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProducts.img!
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: popularProducts.name!,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                            5,
                            (index) {
                              return Icon(
                                Icons.star,
                                color: FoodColor.mainColor,
                                size: 15,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(
                          text: "5",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(
                          text: "1287",
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(
                          text: "comments",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndText(
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: FoodColor.iconColor1,
                        ),
                        IconAndText(
                          icon: Icons.location_on,
                          text: "1.7km",
                          iconColor: FoodColor.mainColor,
                        ),
                        IconAndText(
                          icon: Icons.access_time_rounded,
                          text: "32min",
                          iconColor: FoodColor.iconColor2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
