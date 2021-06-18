import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home.dart';
import './providers/database.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseHelper>(
      create: (context) => DatabaseHelper()..createDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepPurple,
            ),
            iconTheme: IconThemeData(
              color: Colors.cyan,
              size: 35,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple,
            )),
        home: HomePage(),
      ),
    );
  }
}
