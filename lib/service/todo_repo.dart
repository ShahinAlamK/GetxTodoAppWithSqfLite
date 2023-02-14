import '../model/task_model.dart';
import 'db_helper.dart';

class TaskRepository{

  DBHelper dbHelper= DBHelper();

  Future addTask(TaskModel taskModel)async{
    var dbClient=await dbHelper.database;
    return await dbClient.insert('taskTodo',taskModel.toMap());
  }

  Future<List<TaskModel>?>getAllTask()async{
    var dbClient=await dbHelper.database;
    List<Map>maps=await dbClient.query("taskTodo");
    List<TaskModel>taskList=[];
    maps.forEach((element) {
      TaskModel taskModel=TaskModel.fromJson(element);
      taskList.add(taskModel);
    });
    return taskList;
  }

  Future<List<TaskModel>?>searchTask(String query)async{
    var dbClient=await dbHelper.database;
    List<Map>maps=await dbClient.query("taskTodo",where: "taskName=?",whereArgs: [query]);
    List<TaskModel>taskList=[];
    maps.forEach((element) {
      TaskModel taskModel=TaskModel.fromJson(element);
      taskList.add(taskModel);
    });
    return taskList;
  }

  Future<List<TaskModel>?>favoriteTask()async{
    var dbClient=await dbHelper.database;
    List<Map>maps=await dbClient.query("taskTodo",where: "isFavorite=?",whereArgs:["isFavorite"]);
    List<TaskModel>taskList=[];
    maps.forEach((element) {
      TaskModel taskModel=TaskModel.fromJson(element);
      taskList.add(taskModel);
    });
    return taskList;
  }

  Future updateFavorite(TaskModel task,bool isFav)async{
    var dbClient=await dbHelper.database;
    return await dbClient.update("taskTodo",{"isFavorite": isFav?1:0},where:"id=?",whereArgs:[task.id]);
  }

  Future updateDone(TaskModel task,bool isDone)async{
    var dbClient=await dbHelper.database;
    return await dbClient.update("taskTodo",{"isDone": isDone?1:0},where:"id=?",whereArgs:[task.id]);
  }

  Future<int?>deleteTask(int id)async{
    var dbClient=await dbHelper.database;
      return await dbClient.delete("taskTodo",where: "id=?",whereArgs:[id]);
  }

  Future<int?>deleteAllTask()async{
    var dbClient=await dbHelper.database;
    return await dbClient.delete("taskTodo");
  }

}