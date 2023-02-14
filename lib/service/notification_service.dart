import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../model/task_model.dart';

class NotificationHelper {

  final FlutterLocalNotificationsPlugin _locationNotificationService=
  FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings=
  const AndroidInitializationSettings("logo");

  Future<void> initialize()async{
    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _locationNotificationService.initialize(settings);
  }


  void notificationSend(String title,String body)async{

    AndroidNotificationDetails details=const AndroidNotificationDetails(
        "channelId",
        "channelName",
        importance: Importance.max,
        priority: Priority.max
    );
    NotificationDetails notificationDetails=NotificationDetails(android: details);
    await _locationNotificationService.show(
        0,
        title,
        body,
        notificationDetails
    );
  }

  void scheduleNotificationSend({required TaskModel taskModel})async{

    var hour=int.parse(taskModel.taskTime!.split(":")[0]);
    var minutes= int.parse(taskModel.taskTime!.split(":")[1].split(" ")[1]);
    AndroidNotificationDetails details=const AndroidNotificationDetails(
        "channelId",
        "channelName",
        importance: Importance.max,
        priority: Priority.max
    );
    NotificationDetails notificationDetails=NotificationDetails(android: details);
    await _locationNotificationService.zonedSchedule(
        0,
        taskModel.taskName,
        taskModel.taskDescription,
        timeCheck(hour,minutes,DateTime.now()),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  timeCheck(hour, minutes,date){
    tz.TZDateTime now=tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    var formattedDate = DateFormat.yMd().parse(date);
    return scheduledDate;
  }
}