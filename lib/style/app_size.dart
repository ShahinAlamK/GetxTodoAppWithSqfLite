import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData ? _queryData;
  static double ? height;
  static double ? width;
  static double ? blockHorizontal;
  static double ? blockVertical;
  init(BuildContext context){
    _queryData = MediaQuery.of(context);
    height =_queryData!.size.height;
    width =_queryData!.size.width;
    blockHorizontal =width!/100;
    blockVertical =height!/100;
  }
}