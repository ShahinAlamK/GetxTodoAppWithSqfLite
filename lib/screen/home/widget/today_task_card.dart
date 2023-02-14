import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../../model/task_model.dart';
import '../../../style/app_color.dart';
import '../../../style/app_fonts.dart';
import '../../../style/app_size.dart';
import '../../../widget/button_clip.dart';
import '../../task_details_screen.dart';

class TodayTaskCard extends StatelessWidget {
  const TodayTaskCard({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    print(taskModel.isFavorite!);
    return ButtonClip(
      highlightColor: kOnSecondary,
      radius: 10,
      color:colorList[taskModel.taskColor!],
      padding: EdgeInsets.only(left: 10),
      onPress: (){
        Get.to(TaskDetails( taskModel:taskModel));
      },
      child: Container(
        height: 170,
        width:SizeConfig.width!/1.5,
        padding:EdgeInsets.only(top: 10,left: 5,right: 15,bottom: 5),
        decoration: BoxDecoration(
            borderRadius:BorderRadius.circular(15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Spacer(),
            Text(taskModel.taskName!,
              maxLines: 2,
              overflow: TextOverflow.clip,
              style:largeFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*4.5,
              ),),

            Spacer(),
            Text(taskModel.taskDescription!,
              maxLines: 2,
              style:mediumFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*3.5,
              ),),

            Spacer(),
            Text(taskModel.taskTime!,
              maxLines: 2,
              style:mediumFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*3.5,
              ),),

            Spacer(),
            Row(
              children: [
                Text(taskModel.isDone==false?"Todo":"Done",
                  maxLines: 2,
                  style:mediumFonts.copyWith(
                    fontSize: SizeConfig.blockHorizontal!*3.5,
                  ),),
                Spacer(),
                taskModel.isFavorite==false?SizedBox():Icon(Icons.favorite,color:Colors.red,)
              ],
            ),

            Spacer(),
          ],
        ),
      ),
    );
  }
}
