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
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepPurple,
            )),
        home: HomePage(),
      ),
    );
  }
}
