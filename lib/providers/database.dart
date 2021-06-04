import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper with ChangeNotifier {
  Database database;

  List<Map> tasks = [];

  void createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 2,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, category TEXT,title TEXT, place TEXT, time TEXT, date TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          notifyListeners();
          // print(tasks[0]['date']);
        });
        print('Database opened');
      },
    );
    notifyListeners();
  }

  Future insertToDatabase({
    @required String cat,
    @required String title,
    @required String place,
    @required String time,
    @required String date,
  }) async {
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'insert into tasks(category,title,place,time,date) values ("$cat","$title","$place","$time","$date")')
          .then((value) {
        print('$value is inserted');
        getDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          // notifyListeners();
          // print(tasks[0]['date']);
        });
      }).catchError((error) => print('error + $error.toString()'));
      notifyListeners();
      return null;
    });
  }

  Future<List<Map>> getDatabase(Database database) async {
    notifyListeners();
    return await database.rawQuery('SELECT * FROM tasks');
  }
}
