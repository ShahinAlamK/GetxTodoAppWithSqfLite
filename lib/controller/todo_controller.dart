import 'package:get/get.dart';
import '../component/util.dart';
import '../model/task_model.dart';
import '../service/todo_repo.dart';

class TaskController extends GetxController{

  TaskRepository taskRep=TaskRepository();
  var _taskList=<TaskModel>[].obs;
  var _totalTaskList=<TaskModel>[].obs;
  var _queryTaskList=<TaskModel>[].obs;
  var _isFavTaskList=<TaskModel>[].obs;
  var _isDoneTaskList=<TaskModel>[].obs;
  var _todayTaskList=<TaskModel>[].obs;


  List<TaskModel> get taskList=>_taskList;
  List<TaskModel> get totalTaskList=>_totalTaskList;
  List<TaskModel> get queryTaskList=>_queryTaskList;
  List<TaskModel> get todayTaskList=>_todayTaskList;
  List<TaskModel> get isFavTaskList=>_isFavTaskList;
  List<TaskModel> get isDoneTaskList=>_isDoneTaskList;


@override
  void onReady() {
  totalTask();
  fetchTask();
  fetchFavoriteTask();
  fetchTodayTask();
  fetchDoneTask();
  super.onReady();
  }

  void changeValue(String value){
  var query=value;
    queryTask(query);
    totalTask();
    update();
  }

  void addTask(TaskModel taskModel){
      taskRep.addTask(taskModel);
      totalTask();
      fetchTask();
      fetchTodayTask();
      fetchDoneTask();
      update();
  }


  Future totalTask()async{
     var taskList=await taskRep.getAllTask();
     _totalTaskList.value=taskList!;
     update();
  }

  Future fetchTask()async{
     var taskList=await taskRep.getAllTask();
     _taskList.value=taskList!.where((element) => element.isDone==false).toList();
     update();
  }

  Future fetchTodayTask()async{
     var taskList=await taskRep.getAllTask();
     _todayTaskList.value=taskList!.where((element) => element.taskDate!.contains(dateFormat(DateTime.now()))).toList();
     update();
  }

  Future fetchFavoriteTask()async{
     var taskList=await taskRep.getAllTask();
       _isFavTaskList.value=taskList!.where((element) => element.isFavorite!).toList();
     update();
  }

  Future fetchDoneTask()async{
     var taskList=await taskRep.getAllTask();
       _isDoneTaskList.value=taskList!.where((element) => element.isDone!).toList();
     update();
  }

  Future queryTask(String query)async{
    var taskList=await taskRep.getAllTask();
    _queryTaskList.value=taskList!.where((element) => element
        .taskName!.toLowerCase()
        .contains(query.toLowerCase())).toList();
    totalTask();
    update();
  }

  Future updateFavTask(TaskModel task,bool isFav)async{
  await taskRep.updateFavorite(task,isFav);
  fetchTask();
  totalTask();
  fetchFavoriteTask();
  fetchTodayTask();
  fetchDoneTask();
  update();
  }

  Future updateDoneTask(TaskModel task,bool isDone)async{
  await taskRep.updateDone(task,isDone);
  fetchTask();
  totalTask();
  fetchFavoriteTask();
  fetchTodayTask();
  fetchDoneTask();
  update();
  }

  Future deleteTask(int id)async{
    await taskRep.deleteTask(id);
    totalTask();
    fetchTask();
    fetchFavoriteTask();
    fetchTodayTask();
    fetchDoneTask();
    update();
  }

  Future deleteAllTask()async{
    taskRep.deleteAllTask();
    fetchTask();
    totalTask();
    fetchFavoriteTask();
    fetchTodayTask();
    fetchDoneTask();
    update();
  }

}