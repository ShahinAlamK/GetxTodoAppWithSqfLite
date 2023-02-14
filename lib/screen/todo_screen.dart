import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../model/task_model.dart';
import '../style/app_color.dart';
import '../style/app_fonts.dart';
import '../style/app_size.dart';
import '../widget/round_icon.dart';
import '../widget/task_card.dart';
import 'create_todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  TaskController controller=Get.put(TaskController());

  @override
  void initState() {
    controller.fetchTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:kPrimary,
        scrolledUnderElevation: 1,
        automaticallyImplyLeading: false,
        title:Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            RoundIcon(icon: Icons.arrow_back, onPress: (){
              Get.back();
            }),
            Spacer(),

            Text("Task Todo",
              style:largeFonts.copyWith(
                  color:Colors.black,
                  fontSize:SizeConfig.blockHorizontal!*6
              ),),

            Spacer(),
            RoundIcon(icon:Icons.create, onPress:(){
              Get.to(CreateTodo());
            }),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child:Obx((){
          if(controller.taskList.isEmpty){
            return Center(
              child: SvgPicture.asset(
                "assets/icons/empty.svg",
                height:SizeConfig.height!*.3,
              ),
            );
          }else{
            return ListView.separated(
                physics:BouncingScrollPhysics(),
                separatorBuilder:(_,size){
                  return SizedBox(height: 10,);
                },
                itemCount: controller.taskList.length,
                itemBuilder: (_,index){
                  TaskModel taskModel=controller.taskList[index];
                    return TaskCard(taskModel: taskModel);
                });
          }
        }),
      ),

    );
  }
}

