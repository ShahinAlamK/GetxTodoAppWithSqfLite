
class TaskModel{
  int ? id;
  String ? taskName;
  String ? taskDescription;
  String ? taskDate;
  String ? taskTime;
  int ? taskColor;
  bool ? isFavorite;
  bool ? isDone;

  TaskModel({
    this.id,
    this.taskName,
    this.taskDescription,
    this.taskDate,
    this.taskTime,
    this.taskColor,
    this.isFavorite,
    this.isDone,
  });

  Map<String,dynamic>toMap(){
    return {
      "id":this.id,
      "taskName":this.taskName,
      "taskDescription":this.taskDescription,
      "taskDate":this.taskDate,
      "taskTime":this.taskTime,
      "taskColor":this.taskColor,
      "isFavorite":this.isFavorite,
      "isDone":this.isDone,
    };
  }

  factory TaskModel.fromJson(Map<dynamic,dynamic>json){
    return TaskModel(
      id: json['id'],
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      taskDate: json['taskDate'],
      taskTime: json['taskTime'],
      taskColor: json['taskColor'],
      isFavorite:json['isFavorite']== 1? true:false,
      isDone:json['isDone']== 1? true:false,
    );
  }

}