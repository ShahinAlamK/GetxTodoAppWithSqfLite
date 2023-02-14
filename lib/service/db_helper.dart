import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  static final _dbName="testdb.db";
  static final _version=1;
  static final _tableName='taskTodo';

  static Database ? _db;

  Future<Database>get database async{
    if(_db!=null)return _db!;
    _db = await initDatabase();
    return _db!;
  }

  Future initDatabase()async{
    String path= join(await getDatabasesPath(),_dbName);
    return await openDatabase(path,version: _version,onCreate: onCreate);
  }

  FutureOr<void> onCreate(Database db, int version)async {
    return await db.execute("CREATE TABLE $_tableName("
        "id INTEGER PRIMARY KEY autoincrement,"
        "taskName TEXT,"
        "taskDescription TEXT,"
        "taskDate TEXT,"
        "taskTime TEXT,"
        "taskColor INTEGER,"
        "isFavorite INTEGER,"
        "isDone INTEGER"
        ")");
  }
}