import 'package:flutter/material.dart';
import '../../component/util.dart';
import '../../controller/setting_controller.dart';
import '../../controller/todo_controller.dart';
import '../../model/task_model.dart';
import '../../service/notification_service.dart';
import '../../style/app_color.dart';
import '../../style/app_fonts.dart';
import '../../style/app_size.dart';
import '../../widget/button_clip.dart';
import '../../widget/round_icon.dart';
import '../../widget/type_button.dart';
import 'package:get/get.dart';
import '../task/done_screen.dart';
import '../task/favorite_screen.dart';
import '../task/task_screen.dart';
import '../todo_screen.dart';
import 'widget/create_task.dart';
import 'widget/custom_drawer.dart';
import 'widget/custom_floatbutton.dart';
import 'widget/search_button.dart';
import 'widget/today_task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationHelper notificationHelper = NotificationHelper();
  TaskController controller = Get.put(TaskController());
  SettingController settingController = Get.put(SettingController());
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.fetchTask();
    controller.fetchTodayTask();
    settingController.readeName();
    notificationHelper.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _drawerKey,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            RoundIcon(
                icon: Icons.menu,
                onPress: () {
                  _drawerKey.currentState!.openDrawer();
                }),
            Spacer(),

            Text("Todo App",
              style: largeFonts.copyWith(
                  color: Colors.black,
                  fontSize: SizeConfig.blockHorizontal! * 6),
            ),

            Spacer(),
            CircleAvatar(
              radius: 17,
              backgroundImage: AssetImage("assets/placeholder.png"),
            )
            //RoundIcon(icon: Icons.person, onPress: () {}),
          ],
        ),
      ),

      drawer: CustomDrawer(),

      floatingActionButton: CustomFloatButton(),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [

            SizedBox(height: SizeConfig.blockVertical! * 3.0),
            Obx(() => Text("Good ${greeting()}, ${settingController.username}",
                style: largeFonts.copyWith(
                    fontSize: SizeConfig.blockHorizontal! * 4.5,
                    color: Colors.black54),
              ),
            ),

            SizedBox(height: SizeConfig.blockVertical! * 2),
            Obx(() => Text(
                controller.totalTaskList.isEmpty
                    ? "You don't have tasks for this month yet!"
                    : "You have ${controller.totalTaskList.length} tasks this month!",
              style: largeFonts.copyWith(fontSize: SizeConfig.blockHorizontal! * 7),
              ),
            ),

            SizedBox(height: SizeConfig.blockVertical! * 3.5),
            SearchButton(),

            SizedBox(height: SizeConfig.blockVertical! * 3),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TypeButton(
                    title: "ToDo",
                    icon: Icons.checklist,
                    color: Colors.blue,
                    onPress: () {
                      Get.to(() => TodoScreen());
                    },
                  ),
                  SizedBox(width: 20),
                  TypeButton(
                    title: "Done",
                    icon: Icons.done,
                    color: Colors.green,
                    onPress: () {
                      Get.to(() => DoneScreen());
                    },
                  ),
                  SizedBox(width: 20),
                  TypeButton(
                    title: "Favorite",
                    icon: Icons.favorite,
                    color: Colors.red,
                    onPress: () {
                      Get.to(() => FavoriteScreen());
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: SizeConfig.blockVertical! * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Today's Tasks",
                  style: largeFonts.copyWith(
                      fontSize: SizeConfig.blockHorizontal! * 5.5),
                ),
                ButtonClip(
                  color: Colors.transparent,
                  radius: 50,
                  highlightColor: kOnSecondary,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  onPress: () {
                    Get.to(() => TaskScreen());
                  },
                  child: Text("See All",
                    style: largeFonts.copyWith(
                        fontSize: SizeConfig.blockHorizontal! * 4.5,
                        color: Colors.grey),
                  ),
                )
              ],
            ),

            SizedBox(height: SizeConfig.blockVertical! * 1.5),
            Obx(() {
              if (controller.todayTaskList.isEmpty) {
                return CreateOne();
              }
              return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children:
                        List.generate(controller.todayTaskList.length, (index) {
                      TaskModel taskModel = controller.todayTaskList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TodayTaskCard(taskModel: taskModel),
                      );
                    }),
                  ));
            }),
          ],
        ),
      ),
    );
  }
}


