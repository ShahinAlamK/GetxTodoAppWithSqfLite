import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/util.dart';
import '../controller/todo_controller.dart';
import '../model/task_model.dart';
import '../service/notification_service.dart';
import '../style/app_color.dart';
import '../style/app_fonts.dart';
import '../style/app_size.dart';
import '../widget/button_clip.dart';
import '../widget/color_plate.dart';
import '../widget/round_icon.dart';


class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {

  TaskController controller=Get.put(TaskController());

  TextEditingController _taskController=TextEditingController();
  TextEditingController _descriptionController=TextEditingController();
  String date=dateFormat(DateTime.now());
  String time=timeFormat(DateTime.now());
  int selectColor=0;
  Random random = new Random();
  int index = 0;
  NotificationHelper notificationHelper=NotificationHelper();

  void changeIndex() {
    setState(() => index = random.nextInt(colorList.length));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor:kPrimary,
        title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RoundIcon(icon: Icons.arrow_back, onPress: (){
              Get.back();
            }),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: ListView(
          physics:BouncingScrollPhysics(),
          children: [

            SizedBox(height:SizeConfig.blockVertical!*1.5),

            CustomField(
              controller: _taskController,
              textInputAction: TextInputAction.done,
              title: "Task Title",
              hint: "Task Title",
            ),
            SizedBox(height:SizeConfig.blockVertical!*2.5),

            Row(
              children: [
                Expanded(
                  child: DateTimePicker(
                    title:"Date",
                    icon: Icons.date_range,
                    hint:date,
                    onPress:(){
                      _pickFormDate();
                    },
                  ),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: DateTimePicker(
                    title:"Time",
                    icon:Icons.access_time_outlined,
                    hint:time,
                    onPress:(){
                      _pickFormTime();
                    },
                  ),
                )
              ],
            ),
            SizedBox(height:SizeConfig.blockVertical!*2.5),

            CustomField(
              controller:_descriptionController,
              title: "Description",
              hint: "Description...",
              maxLines: 6,
            ),
            SizedBox(height:SizeConfig.blockVertical!*2.5),

            Text("Color",style:largeFonts.copyWith(
                color:colorList[selectColor],
                fontSize: SizeConfig.blockHorizontal!*3.8),),
            SizedBox(height:SizeConfig.blockVertical!*1),

            SingleChildScrollView(
              physics:BouncingScrollPhysics() ,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(colorList.length, (index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 10,),
                    child: ButtonClip(
                      color: Colors.transparent,
                      radius: 100,
                      padding: EdgeInsets.only(right:0),
                      onPress: (){
                        setState(() {
                          selectColor=index;
                        });
                      },
                      child: ColorPlate(
                        selectColor: selectColor,
                        index: index
                      ),
                    ),
                  );
                }),
              ),
            ),

            SizedBox(height:SizeConfig.blockVertical!*5),
            
            ButtonClip(
              radius: 10,
              color:kSecondary,
              highlightColor: kOnSecondary,
              padding:EdgeInsets.symmetric(vertical: 5),
              onPress: (){
                _validTask();
              },
              child: SizedBox(
                height:40,
                width:SizeConfig.width,
                child:Center(child: Text("Save Task",
                style:largeFonts.copyWith(
                  fontSize:SizeConfig.blockHorizontal!*5
                ),)),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _validTask()async{
    if(_taskController.text.isEmpty || _descriptionController.text.isEmpty){
      changeIndex();
      Get.snackbar("Required", "All field input can't be empty",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 10,right: 10,left: 10),
          backgroundColor:Colors.red,
          colorText: Colors.white
      );
    }else{
      TaskModel taskModel=TaskModel(
        taskName: _taskController.text,
        taskDescription: _descriptionController.text,
        taskDate: date,
        taskTime: time,
        taskColor: selectColor,
      );
      controller.addTask(taskModel);
      Get.back();
      Get.snackbar("Successfully", "Your task properly added databases",
          margin: EdgeInsets.only(bottom: 10,right: 10,left: 10),
          backgroundColor:colorList[selectColor],
          colorText: Colors.white
      );
    }
  }

  Future _pickFormDate()async{
    final getDate=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.orangeAccent, // <-- SEE HERE
                onPrimary: Colors.black, // <-- SEE HERE
                onSurface:Colors.black54, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  backgroundColor:Colors.transparent,
                    foregroundColor: Colors.black54
                ),
              ),
            ),
            child: child!,
          );
        }
    );
    if(getDate!=null){
      setState(() {
       date=dateFormat(getDate);
      });
    }else{
      print("Something Wrong");
    }
  }
  Future _pickFormTime()async{
    final getTime=await showTimePicker(
        context: context,
        initialTime:TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.orangeAccent, // <-- SEE HERE
                onPrimary: Colors.black, // <-- SEE HERE
                onSurface:Colors.black54, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor:Colors.transparent,
                    foregroundColor: Colors.black54
                ),
              ),
            ),
            child: child!,
          );
        }
    );
    if(getTime!=null){
     setState(() {
       print(getTime.format(context));
       time=getTime.format(context);
     });
    }
  }
}


class CustomField extends StatelessWidget {
  final String title;
  final String hint;
  final IconData? icon;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  const CustomField({
    super.key,
    required this.title,
    required this.hint,
    this.textInputAction,
    this.icon, this.maxLines,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text(title,
        style:largeFonts ,),
        SizedBox(height:5),

        Container(
          padding:EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          decoration:BoxDecoration(
            border:Border.all(color:kOnSecondary),
            borderRadius:BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            maxLines:maxLines ,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:largeFonts.copyWith(fontSize: SizeConfig.blockHorizontal!*3.8),
              border:InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class DateTimePicker extends StatelessWidget {
  final String title;
  final String hint;
  final IconData icon;
  final Function onPress;
  const DateTimePicker({Key? key,
    required this.title,
    required this.hint,
    required this.onPress,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Text(title,
          style:largeFonts ,),
        SizedBox(height:5),

        ButtonClip(
          padding: EdgeInsets.zero,
          radius:10,
          color: Colors.transparent,
          onPress: ()=>onPress(),
          highlightColor:kSecondary,
          child: Container(
            height: 50,
            padding:EdgeInsets.symmetric(horizontal: 10,vertical: 3),
            decoration:BoxDecoration(
              border:Border.all(color:kOnSecondary),
              borderRadius:BorderRadius.circular(10),
            ),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(hint,style:largeFonts.copyWith(fontSize: SizeConfig.blockHorizontal!*3.8),),
                Icon(icon)
              ],
            ),
          ),
        ),
      ],
    );
  }
}



