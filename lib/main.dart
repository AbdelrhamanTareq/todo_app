import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';
import './providers/database.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final DatabaseHelper databaseHelper = DatabaseHelper();
  // databaseHelper.createDatabase();
  runApp(MyApp(
      // databaseHelper
      ));
}

class MyApp extends StatelessWidget {
  // final DatabaseHelper databaseHelper;
  // MyApp(this.databaseHelper);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseHelper>(
      create: (context) => DatabaseHelper()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
