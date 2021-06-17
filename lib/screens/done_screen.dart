import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_view.dart';
import '../providers/database.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<dynamic, dynamic>> data =
        Provider.of<DatabaseHelper>(context).doneTasks;

    print('data $data');
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Tasks'),
      ),
      body: ListViewWidget(
        data: Provider.of<DatabaseHelper>(context).doneTasks,
        function: () {
          // print('cbcvbcb');
        },
      ),
    );
  }
}
