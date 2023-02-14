import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../style/app_color.dart';
import '../../../style/app_fonts.dart';
import '../../../style/app_size.dart';
import '../../../widget/button_clip.dart';
import '../../create_todo.dart';

class CreateOne extends StatelessWidget {
  const CreateOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: 180,
      width:SizeConfig.width,
      decoration: BoxDecoration(
          color: kSecondary,
          borderRadius:BorderRadius.circular(15)
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("You don't have task for today",
            style:mediumFonts.copyWith(
                fontSize: SizeConfig.blockHorizontal!*4.5
            ),),

          ButtonClip(
            color:Colors.transparent,
            highlightColor:kOnSecondary,
            padding:EdgeInsets.zero,
            radius: 50,
            onPress: (){
              Get.to(CreateTodo());
            },
            child: Container(
              padding:EdgeInsets.all(15),
              child: Text("Click Here to Create One",
                style:largeFonts.copyWith(
                    fontSize: SizeConfig.blockHorizontal!*4.5
                ),),
            ),
          ),
        ],
      ),
    );
  }
}
