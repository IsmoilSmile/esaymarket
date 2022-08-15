import 'package:esaymarket/widgets_page/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(
          height: Dimensions.height10,
        ),
        SmallText(text: "With a captivating performance"),
        SizedBox(
          height: Dimensions.height10,
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
    );
  }
}
