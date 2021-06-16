import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper with ChangeNotifier {
  Database database;

  List<Map> tasks = [];
  List<Map> doneTasks = [];

  Future createDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 2,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, category TEXT,title TEXT, place TEXT, time TEXT, date TEXT, complete INTEGER, icon INTEGER, status Text)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDatabase(database);
        getDoneDatabase(database);
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
    @required int icon,
  }) async {
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'insert into tasks(category,title,place,time,date,complete,icon,status) values ("$cat","$title","$place","$time","$date",0,$icon,"All")')
          .then((value) {
        print('$value is inserted');
        getDatabase(database);
        getDoneDatabase(database);
      }).catchError((error) => print('error + $error.toString()'));
      notifyListeners();
      return null;
    });
  }

  void getDatabase(Database database) {
    database
        .rawQuery('SELECT * FROM tasks WHERE status = "All" ORDER BY id DESC')
        .then((value) {
      tasks = value;
      print('tasks = $tasks');
      notifyListeners();
      // print(tasks[0]['date']);
    });

    notifyListeners();
  }

  void getDoneDatabase(Database database) {
    doneTasks = [];
    database
        .rawQuery('SELECT * FROM tasks WHERE status = "Done" ORDER BY id DESC')
        .then((value) {
      doneTasks = value;

      notifyListeners();
      print('done $doneTasks ');
      print('done length ${doneTasks.length} ');
    });

    notifyListeners();
  }

  Future<int> getCategoryCount({String catName}) async {
    var x = await database
        .rawQuery("SELECT COUNT (*) from tasks where category = '$catName'");
    int count = Sqflite.firstIntValue(x);
    // print('c = $count ');
    // print('+ x = $x ');
    return count;
  }

  Future<void> updateDatabase(
    int id,
  ) async {
    int updated = await database.rawUpdate(
      'UPDATE tasks SET complete = ?, status = ? WHERE id = ?',
      [
        1,
        "Done",
        id,
      ],
    );
    getDatabase(database);
    getDoneDatabase(database);
    print('update = $updated');
    notifyListeners();
    // if (isClicked == false) {
    //   int updated = await database.rawUpdate(
    //     'UPDATE tasks SET complete = ? WHERE id = ?',
    //     [
    //       1,
    //       id,
    //     ],
    //   );
    //   getDatabase(database);
    //   notifyListeners();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         content: Container(
    //       child: Text('Task Completed'),
    //     )),
    //   );
    // } else {
    //   int updated = await database.rawUpdate(
    //     'UPDATE tasks SET complete = ? WHERE id = ?',
    //     [
    //       0,
    //       id,
    //     ],
    //   );
    //   getDatabase(database);
    //   notifyListeners();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //         content: Container(
    //       child: Text('Task UnCompleted'),
    //     )),
    //   );
    // }
  }

  Future<int> getCompleteCount() async {
    var x = await database
        .rawQuery("SELECT COUNT (*) from tasks where complete = 1 ");
    int count = Sqflite.firstIntValue(x);
    // double finalCount = count * 0.1;
    print('count complete tasks = $count');

    return count;
  }

  Future<int> getTasksCount() async {
    var x = await database.rawQuery("SELECT COUNT (*) from tasks");
    int count = Sqflite.firstIntValue(x);
    print('count all tasks = $count');
    return count;
  }

  Future<double> getCompletePrecntage() async {
    int x = await getCompleteCount();
    int y = await getTasksCount();
    double z = x / y;
    if (y == 0 || x == 0) {
      return 0.0;
    }
    print(z);
    return z;
  }

  void deleteTask(int id) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);
    getDatabase(database);
    getDoneDatabase(database);
    notifyListeners();
  }
}
