import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/todo_controller.dart';
import '../model/task_model.dart';
import '../style/app_color.dart';
import '../style/app_fonts.dart';
import '../style/app_size.dart';
import '../widget/task_card.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskController taskController=Get.put(TaskController());
    SizeConfig().init(context);

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 1,
        title:  Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (value) {
              taskController.changeValue(value);
           },
            decoration: InputDecoration(
                hintText: "Search a task...",
                hintStyle: largeFonts,
                icon: Icon(Icons.search,size: SizeConfig.blockHorizontal! * 8,),
                border: InputBorder.none
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),

        child: Obx((){
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: taskController.queryTaskList.length,
              itemBuilder:(_,index){
                TaskModel taskModel=taskController.queryTaskList[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TaskCard(taskModel: taskModel),
                );
              });

        }),
      ),

    );
  }
}
