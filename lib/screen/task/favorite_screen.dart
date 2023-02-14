import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/todo_controller.dart';
import '../../model/task_model.dart';
import '../../style/app_color.dart';
import '../../style/app_fonts.dart';
import '../../style/app_size.dart';
import '../../widget/round_icon.dart';
import '../../widget/task_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  TaskController taskController=Get.put(TaskController());
  @override
  void initState() {
    taskController.fetchFavoriteTask();
    taskController.fetchDoneTask();
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

            Text("Favorites Tasks",
              style:largeFonts.copyWith(
                  color:Colors.black,
                  fontSize:SizeConfig.blockHorizontal!*6
              ),),
            Spacer(),


            RoundIcon(icon: Icons.favorite,color:Colors.red, onPress: (){
              Get.back();
            }),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child: Obx((){
          if(taskController.isFavTaskList.isEmpty){
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
                itemCount: taskController.isFavTaskList.length,
                itemBuilder: (_,index){
                  TaskModel taskModel=taskController.isFavTaskList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TaskCard(taskModel: taskModel),
                    );
                });
          }
        }),
      ),

    );
  }
}
