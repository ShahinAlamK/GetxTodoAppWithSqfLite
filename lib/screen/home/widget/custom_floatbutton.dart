
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../style/app_color.dart';
import '../../../style/app_fonts.dart';
import '../../../style/app_size.dart';
import '../../create_todo.dart';

class CustomFloatButton extends StatelessWidget {
  const CustomFloatButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    return FloatingActionButton.extended(
      backgroundColor:kSecondary,
      elevation:0,
      tooltip: "add task",
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      label: Row(
        children: [
          Icon(Icons.add,color:Colors.black),

          Text("Add Task",
            style:largeFonts.copyWith(
                fontSize:SizeConfig.blockHorizontal!*3.5,
                color:Colors.black
            ),)
        ],
      ),
      onPressed: (){
        Get.to(()=>CreateTodo());
      },
    );
  }
}
