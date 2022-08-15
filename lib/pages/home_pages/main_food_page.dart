import 'package:esaymarket/utils/dimensions.dart';
import 'package:esaymarket/widgets_page/big_text.dart';
import 'package:esaymarket/widgets_page/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/color.dart';
import 'food_page_body.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //The header
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "Uzbekistan",
                          color: FoodColor.mainColor,
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Tashkent",
                              color: Colors.black54,
                            ),
                            Icon(Icons.arrow_drop_down_rounded),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: Dimensions.height45,
                      width: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: FoodColor.mainColor,
                      ),
                      child: Center(
                          child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //The body
          Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
