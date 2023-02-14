import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../component/util.dart';
import '../../controller/todo_controller.dart';
import '../../model/task_model.dart';
import '../../style/app_color.dart';
import '../../style/app_fonts.dart';
import '../../style/app_size.dart';
import '../../widget/button_clip.dart';
import '../../widget/round_icon.dart';
import '../../widget/task_card.dart';
import '../create_todo.dart';


class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  TaskController taskController=Get.put(TaskController());

  DateTime _selectDate=DateTime.now();

  @override
  void initState() {
    taskController.fetchTask();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor:kPrimary,
        automaticallyImplyLeading: false,
        title:Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            RoundIcon(icon: Icons.arrow_back, onPress: (){
              Get.back();
            }),
            Spacer(),


            ButtonClip(
              color:kSecondary,
              onPress: (){
                Get.to(()=>CreateTodo());
              },
              radius: 50,
              highlightColor:kOnSecondary,
              padding: EdgeInsets.symmetric(horizontal: 13,vertical: 9),
              child: Row(
                crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,color:Colors.black,),
                  SizedBox(width: 2),
                  Text("Add Task",
                    style:largeFonts.copyWith(
                        color:Colors.black,
                        fontSize:SizeConfig.blockHorizontal!*4
                    ),),
                ],
              ),
            ),
          ],
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child: Column(
          children: [
            Container(
              decoration:BoxDecoration(
                color:kSecondary,
                borderRadius:BorderRadius.circular(10)
              ),
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                onDateChange: (newDate) {
                  setState(() {
                    _selectDate = newDate;
                  });
                },
                width: 60,
                height: 90,
                selectedTextColor: Colors.white,
                selectionColor:kOrange,
                dayTextStyle:
                TextStyle(color:Colors.grey,),
                dateTextStyle:
                TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                monthTextStyle:
                TextStyle(color:Colors.grey,),
              ),
            ),

            Expanded(
              child: Obx((){
                if(taskController.totalTaskList.isEmpty){
                  return Center(
                    child: SvgPicture.asset(
                      "assets/icons/empty.svg",
                      height:SizeConfig.height!*.3,
                    ),
                  );
                }
                else{
                  return ListView.builder(
                    shrinkWrap: true,
                      physics:BouncingScrollPhysics(),
                      itemCount: taskController.totalTaskList.length,
                      itemBuilder: (_,index){
                        TaskModel taskModel=taskController.totalTaskList[index];
                       if(taskModel.taskDate==dateFormat(_selectDate)){
                         return Padding(
                           padding: const EdgeInsets.only(top: 10),
                           child: TaskCard(taskModel: taskModel),
                         );
                       }
                       else{
                         return SizedBox();
                       }
                      });
                }
              }),
            ),

          ],
        ),
      ),

    );
  }
}
