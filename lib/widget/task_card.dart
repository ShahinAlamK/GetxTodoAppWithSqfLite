import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/task_model.dart';
import '../screen/task_details_screen.dart';
import '../style/app_color.dart';
import '../style/app_fonts.dart';
import '../style/app_size.dart';
import 'button_clip.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;
  const TaskCard({
    required this.taskModel,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonClip(
      color:Colors.transparent,
      padding: EdgeInsets.zero,
      onPress:(){
        Get.to(TaskDetails(
          taskModel:taskModel,
        ));
      },
      radius:15,
      child: Container(
        height: 150,
        child: Row(
          children: [

            Expanded(
              child: Container(
                height:SizeConfig.height,
                width:SizeConfig.width,
                decoration:BoxDecoration(
                    color:colorList[taskModel.taskColor!],
                    borderRadius: BorderRadius.circular(15)
                ),
                padding:EdgeInsets.only(left: 20,top:20,right: 20),
                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: [
                    Text(taskModel.taskName!,
                      maxLines: 2,
                      overflow:TextOverflow.ellipsis,
                      style:largeFonts.copyWith(
                          fontSize:SizeConfig.blockHorizontal!*4.7
                      ),),
                    Spacer(),
                    Text(taskModel.taskDescription!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style:largeFonts.copyWith(
                          fontSize:SizeConfig.blockHorizontal!*3.4
                      ),),
                    Spacer(),
                    Text(taskModel.taskTime!,
                      style:largeFonts.copyWith(
                          fontSize:SizeConfig.blockHorizontal!*4.7
                      ),),
                    Spacer(),
                  ],
                ),
              ),
            ),

            SizedBox(width:3),

            Container(
              height:SizeConfig.height,
              width:50,
              decoration:BoxDecoration(
                  color:colorList[taskModel.taskColor!],
                  borderRadius: BorderRadius.circular(15)
              ),
              child: RotatedBox(
                  quarterTurns: 3,
                  child: Center(child: Text(taskModel.isDone==false?"Task":"Done",
                    style:largeFonts.copyWith(
                        fontSize:SizeConfig.blockHorizontal!*4
                    ),))),
            ),
          ],
        ),
      ),
    );
  }
}
