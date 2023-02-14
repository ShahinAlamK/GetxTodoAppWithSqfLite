import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:share_plus/share_plus.dart';
import '../controller/todo_controller.dart';
import '../model/task_model.dart';
import '../style/app_color.dart';
import '../style/app_fonts.dart';
import '../style/app_size.dart';
import '../widget/button_clip.dart';
import '../widget/color_plate.dart';
import '../widget/round_icon.dart';

class TaskDetails extends StatefulWidget {
  final TaskModel taskModel;
  const TaskDetails({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  bool isFavorite = false;
  bool? isDone;

  @override
  void initState() {
    setState(() {
      isFavorite=widget.taskModel.isFavorite!;
      isDone=widget.taskModel.isDone!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(TaskController());
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            RoundIcon(icon: Icons.arrow_back,
                onPress: () {
                  Get.back();
                }),
            Spacer(),
            Text("Task Details",
              style: largeFonts.copyWith(
                  color: Colors.black,
                  fontSize: SizeConfig.blockHorizontal! * 6),
            ),

            Spacer(),
            RoundIcon(
                icon: Icons.favorite,
                color: isFavorite?Colors.red : Colors.black,
                onPress: () {
                  setState(() {
                    isFavorite = !isFavorite;
                    taskController.updateFavTask(widget.taskModel,isFavorite);
                  });
                }),

          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              Text(widget.taskModel.taskName!,
                style: largeFonts.copyWith(
                    fontSize: SizeConfig.blockHorizontal! * 5.5),
              ),
              SizedBox(height: 25),

              Row(
                children: [
                  Icon(Icons.date_range,
                    color: colorList[widget.taskModel.taskColor!],
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  Text(widget.taskModel.taskDate!,
                    style: largeFonts.copyWith(
                        fontSize: SizeConfig.blockHorizontal! * 4),
                  ),
                  SizedBox(width: SizeConfig.blockHorizontal! *6),

                  ColorPlate(
                    index: widget.taskModel.taskColor!,
                    height: SizeConfig.blockHorizontal! *6,
                    width:SizeConfig.blockHorizontal! *6,
                  ),

                  Spacer(),
                  Icon(Icons.access_time_outlined,
                    color: colorList[widget.taskModel.taskColor!],
                  ),

                  SizedBox(width: 10,),
                  Text(
                    widget.taskModel.taskTime!,
                    style: largeFonts.copyWith(
                        fontSize: SizeConfig.blockHorizontal! * 4),
                  ),
                ],
              ),
              SizedBox(height: 25),

              Row(
                children: [
                  Icon(
                    widget.taskModel.isDone==false?Icons.checklist:Icons.done,
                    color: colorList[widget.taskModel.taskColor!],
                  ),
                  
                  SizedBox(width: 10,),
                  
                  Text("Status : ${checkStatus(widget.taskModel)}",
                    style: largeFonts.copyWith(
                        fontSize: SizeConfig.blockHorizontal! * 4),
                  ),
                  
                  Spacer(),

                  ButtonClip(
                    color:Colors.transparent,
                    radius: 50,
                    highlightColor:kOnSecondary,
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    onPress: (){
                      _onShare(context);
                    },
                    child: Row(
                    children: [
                      Icon(Icons.share,
                        color: colorList[widget.taskModel.taskColor!],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Share",
                        style: largeFonts.copyWith(
                            fontSize: SizeConfig.blockHorizontal! * 4),
                      ),
                    ],
                ),
                  )
                ],
              ),
              
              SizedBox(height: 25),

              Text("Description",
                style: largeFonts.copyWith(
                    fontSize: SizeConfig.blockHorizontal! * 5.5),
              ),
              SizedBox(height: 10),

              Text(widget.taskModel.taskDescription!,
                style: smallFonts.copyWith(
                    fontSize: SizeConfig.blockHorizontal! * 4),
              ),
              SizedBox(height: 40),

              Row(
                children: [
                 
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        padding:
                        MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10,vertical: 15)),
                        backgroundColor:MaterialStateProperty.all(colorList[widget.taskModel.taskColor!]),
                        elevation:MaterialStateProperty.all(0),
                        shape:MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                      ),
                        onPressed:isDone==true?null:(){
                      setState(() {
                        isDone=!isDone!;
                        taskController.updateDoneTask(widget.taskModel, isDone!);
                      });
                      Get.back();},
                        child: Text("Done",style: largeFonts.copyWith(
                        fontSize: SizeConfig.blockHorizontal! * 5),)),
                  ),

                  SizedBox(width: 10,),
                  
                  Expanded(
                    child: ButtonClip(
                        radius: 10,
                        color: Colors.red.shade300,
                        onPress: () {

                          Get.defaultDialog(
                            title:"Attention Please",
                            content: Text("Permanently your task delete from databases"),

                            cancel:ButtonClip(
                                color:kSecondary,
                                padding: EdgeInsets.all(10),
                                radius: 10,
                                highlightColor:kOnSecondary,
                                onPress: (){
                                  Get.back();
                                },
                                child: Text("Cancel",style:largeFonts)),
                            confirm:ButtonClip(
                                color:Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                radius: 10,
                                highlightColor:kOnSecondary,
                                onPress: (){
                                  taskController.deleteTask(widget.taskModel.id!);
                                  Get.back();
                                },
                                child: Text("Yes",style:largeFonts.copyWith(color:Colors.white),)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            titlePadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                          ).whenComplete(() => Get.back());
                        },
                        padding:EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        highlightColor: kSecondary,
                        child: Center(
                            child: Text("Delete",
                              style: largeFonts.copyWith(
                              fontSize: SizeConfig.blockHorizontal! * 5),
                            ))),
                  ),

                ],
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }

  checkStatus(TaskModel task){
    if(task.isDone==true){
      return 'Done';
    }else{
      return 'Todo';
    }
  }
  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        widget.taskModel.taskDescription!,
        subject: widget.taskModel.taskDescription!,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
