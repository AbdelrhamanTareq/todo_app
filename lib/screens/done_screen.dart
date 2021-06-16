import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/database.dart';

class DoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<dynamic, dynamic>> data =
        Provider.of<DatabaseHelper>(context).doneTasks;
    final provider = Provider.of<DatabaseHelper>(context);
    print('data $data');
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Tasks'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1500,
          child: ListView.separated(
              itemBuilder: (ctx, i) => Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Theme.of(context).errorColor,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                    ),
                    onDismissed: (dirction) {
                      provider.deleteTask(data[i]['id']);
                    },
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Are you sure'),
                          content: Text('Do you want to remove this task?'),
                          actions: [
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    child: InkWell(
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            IconData(data[i]['icon'],
                                fontFamily: 'MaterialIcons'),
                          ),
                        ),
                        title: Text(data[i]['title']),
                        subtitle: Text(data[i]['place']),
                        trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[i]['time']),
                              SizedBox(
                                height: 5,
                              ),
                              Text(data[i]['date']),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (ctx, i) => Container(
                    padding: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    )),
                  ),
              itemCount: data.length),
          //     //  ListView.builder(
          //     //   itemCount: data.length,
          //     //   itemBuilder: (context, i) => ListTile(
          //     //     title: Text(data[i]['title']),
          //     //     trailing: Text(data[i]['date']),
          //     //   ),
          //     // ),

          //     ListView.separated(
          //   itemBuilder: (ctx, i) => ListView.separated(
          //     padding: EdgeInsets.all(2),
          //     shrinkWrap: true,
          //     itemBuilder: (ctx, i) => Dismissible(
          //       key: UniqueKey(),
          //       background: Container(
          //         color: Theme.of(context).errorColor,
          //         child: Icon(
          //           Icons.delete,
          //           color: Colors.white,
          //           size: 40,
          //         ),
          //         alignment: Alignment.centerRight,
          //         padding: EdgeInsets.only(right: 20),
          //       ),
          //       onDismissed: (dirction) {
          //         provider.deleteTask(data[i]['id']);
          //       },
          //       direction: DismissDirection.endToStart,
          //       confirmDismiss: (direction) {
          //         return showDialog(
          //           context: context,
          //           builder: (ctx) => AlertDialog(
          //             title: Text('Are you sure'),
          //             content: Text('Do you want to remove this task?'),
          //             actions: [
          //               TextButton(
          //                 child: Text('No'),
          //                 onPressed: () {
          //                   Navigator.of(context).pop();
          //                 },
          //               ),
          //               TextButton(
          //                 child: Text('Yes'),
          //                 onPressed: () {
          //                   Navigator.of(context).pop(true);
          //                 },
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //       child: InkWell(
          //         onTap: () {
          //           // _onSelected(providr.tasks[i]['id']);
          //           // print('ink tapped');
          //         },
          //         child: ListTile(
          //           leading: Container(
          //             width: 50,
          //             height: 50,
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.grey, width: 0.5),
          //               shape: BoxShape.circle,
          //             ),
          //             child: Icon(
          //               IconData(data[i]['icon'], fontFamily: 'MaterialIcons'),
          //             ),
          //           ),
          //           title: Text(data[i]['title']),
          //           subtitle: Text(data[i]['place']),
          //           trailing: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(data[i]['time']),
          //                 SizedBox(
          //                   height: 5,
          //                 ),
          //                 Text(data[i]['date']),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     separatorBuilder: (ctx, i) => Container(
          //       padding: EdgeInsets.only(top: 0),
          //       decoration: BoxDecoration(
          //           border: Border(
          //         bottom: BorderSide(color: Colors.grey, width: 0.5),
          //       )),
          //     ),
          //     itemCount: data.length,
          //   ),
          //   separatorBuilder: (ctx, i) => Container(),
          //   itemCount: data.length,
          // ),
        ),
      ),
    );
  }
}
