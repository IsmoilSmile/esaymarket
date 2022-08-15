import 'package:esaymarket/utils/color.dart';
import 'package:esaymarket/utils/dimensions.dart';
import 'package:esaymarket/widgets_page/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandbleTextWidget extends StatefulWidget {
  final String text;
  const ExpandbleTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandbleTextWidget> createState() => _ExpandbleTextWidgetState();
}

class _ExpandbleTextWidgetState extends State<ExpandbleTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 5.63;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length > textHeight){
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(color: FoodColor.paraColor,text: firstHalf):
      Column(
        children: [
          SmallText(height:1.8,color: FoodColor.paraColor,size: Dimensions.font16,text: hiddenText?(firstHalf + "..."):(firstHalf + secondHalf)),
          InkWell(
            onTap: (){
              setState(() {

                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(height:1.8,text: "Show more ",color: FoodColor.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: FoodColor.mainColor,),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
