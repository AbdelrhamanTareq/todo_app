import 'package:flutter/material.dart';

showScaffoldSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(milliseconds: 500),
  ));
}

// futureBuilder({Future future, data, Widget widget}) {
//   return FutureBuilder(
//       future: future,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final snapshotData = snapshot.data;
//           data = snapshotData;
//           return widget;
//           //  Text(
//           //   '${((snapshot.data)).toInt()}',
//           //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           // )

//         }
//         return Container();
//       });
// }
