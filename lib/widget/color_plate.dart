import 'package:flutter/material.dart';
import '../style/app_color.dart';

class ColorPlate extends StatelessWidget {
  const ColorPlate({
    super.key,
    this.selectColor,
    this.index,
    this.height=35,
    this.width=35,
  });

  final int? selectColor;
  final int? index;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape:BoxShape.circle,
        color:colorList[index!].withOpacity(.6),
        border: Border.all(color:colorList[index!]),
      ),
      child: Center(child:selectColor==index?Icon(Icons.done,color:Colors.white,):SizedBox(),),
    );
  }
}