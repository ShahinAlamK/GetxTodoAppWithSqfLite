import 'package:flutter/material.dart';

import '../style/app_color.dart';
import '../style/app_size.dart';

class RoundIcon extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final Color ? color;
  const RoundIcon({Key? key,
    required this.icon,
    required this.onPress,
    this.color=Colors.black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ClipRRect(
      borderRadius:BorderRadius.circular(100),
      child: Material(
        color: kSecondary,
        child: InkWell(
          onTap:()=>onPress(),
          child: Container(
            padding:EdgeInsets.all(8),
            decoration:BoxDecoration(
                color:Colors.transparent,
                shape:BoxShape.circle
            ),
            child:Icon(icon,color:color,),
          ),
        ),
      ),
    );
  }
}
