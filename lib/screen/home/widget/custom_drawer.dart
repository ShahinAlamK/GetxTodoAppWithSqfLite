import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/setting_controller.dart';
import '../../../controller/todo_controller.dart';
import '../../../style/app_color.dart';
import '../../../style/app_fonts.dart';
import '../../../style/app_size.dart';
import '../../../widget/button_clip.dart';
import '../../create_todo.dart';
import '../../task/favorite_screen.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingController settingController=Get.put(SettingController());
    TaskController taskController=Get.put(TaskController());
    SizeConfig().init(context);
    return Drawer(
      width: SizeConfig.width!/5*3.5,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [

            Container(
              height: SizeConfig.blockVertical!*25,
              width:SizeConfig.width,
              decoration:BoxDecoration(
                  color:kOnSecondary
              ),
              child:Center(
                child: Text("Todo App",
                  style:largeFonts.copyWith(
                      fontSize:SizeConfig.blockHorizontal!*7
                  ),),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home_filled,color:colorList[3],),
              title: Text("Home",style: largeFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*4.3
              ),),
              minLeadingWidth: 6,
              onTap:(){
                Get.back();
              },
            ),

            ListTile(
              leading: Icon(Icons.favorite,color:colorList[2]),
              title: Text("Favorite",style: largeFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*4.3
              ),),
              trailing: Text(taskController.isFavTaskList.length.toString()),
              minLeadingWidth: 6,
              onTap:(){
                Get.back();
                Get.to(()=>FavoriteScreen());
              },
            ),

            ListTile(
              leading: Icon(Icons.create,color:colorList[4]),
              title: Text("Create Task",style: largeFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*4.3
              ),),
              minLeadingWidth: 6,
              onTap:(){
                Get.back();
                Get.to(()=>CreateTodo());
              },
            ),

            ListTile(
              leading: Icon(Icons.settings,color:colorList[1]),
              title: Text("Settings",style: largeFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*4.3
              ),),
              minLeadingWidth: 6,
              onTap:(){
                Get.back();
                Get.defaultDialog(
                    contentPadding:EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                    title: "Username",
                    titlePadding: EdgeInsets.only(top: 20),
                    content: Column(
                      children: [
                        SizedBox(height: 10,),

                        TextFormField(
                          controller: settingController.userNameController,
                          onSaved: (value){},
                          decoration:InputDecoration(
                            hintText: "Enter Name",
                            focusColor:kSecondary,
                            contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            border: OutlineInputBorder(),
                          ),
                        ),

                        SizedBox(height: 10,),
                        ButtonClip(
                            onPress: (){
                              settingController.userValid();
                            },
                            color: kSecondary,
                            highlightColor:kOnSecondary,
                            radius: 10,
                            padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                            child: Text("Save",style: largeFonts.copyWith(
                                fontSize: SizeConfig.blockHorizontal!*4
                            ),)),
                      ],
                    )
                );
              },
            ),


            ListTile(
              leading: Icon(Icons.delete,color:Colors.red),
              title: Text("Delete All",style: largeFonts.copyWith(
                  fontSize: SizeConfig.blockHorizontal!*4.3
              ),),
              minLeadingWidth: 6,
              onTap:(){
                Get.back();
                Get.defaultDialog(
                  title:"Attention Please",
                  content: Text("Permanently your all task delete from databases"),

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
                        taskController.deleteAllTask();
                        Get.back();
                      },
                      child: Text("Yes",style:largeFonts.copyWith(color:Colors.white),)),

                  contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                  titlePadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
