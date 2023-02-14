import 'package:flutter/material.dart';

import '../style/app_fonts.dart';
import '../style/app_size.dart';

class TypeButton extends StatelessWidget {
  final Function onPress;
  final String title;
  final IconData icon;
  final Color color;
  const TypeButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ClipRRect(
      borderRadius:BorderRadius.circular(50),
      child: Material(
        color:Colors.grey.shade100,
        child: InkWell(
          onTap: () => onPress(),
          child: Container(
            height: 150,
            width: 100,
            padding:EdgeInsets.symmetric(horizontal: 10,vertical:5),
            decoration:BoxDecoration(
              color:Colors.transparent,
              //borderRadius: BorderRadius.circular(50)
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:EdgeInsets.all(15),
                  decoration:BoxDecoration(
                    color:color.withOpacity(.1),
                    border: Border.all(color:color,width:2),
                    shape:BoxShape.circle,
                  ),
                  child:Center(child: Icon(icon,color:color)),
                ),

                SizedBox(height: 15,),
                Text(title,
                  style:largeFonts.copyWith(
                      fontSize:SizeConfig.blockHorizontal!*4.5
                  ),),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
