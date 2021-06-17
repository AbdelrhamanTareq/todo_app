import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/constant.dart';
import '../providers/database.dart';

class ListViewWidget extends StatelessWidget {
  final List data;
  final Function function;

  const ListViewWidget({
    this.data,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    _onSelected(
      int id,
    ) {
      Provider.of<DatabaseHelper>(context, listen: false).updateDatabase(id);

      showScaffoldSnackBar(context, 'Task Complet');
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      print('tappppppppppp');
    }

    final provider = Provider.of<DatabaseHelper>(context);

    return ListView.separated(
        padding: EdgeInsets.all(0),
        itemBuilder: (ctx, i) {
          return Dismissible(
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
              showScaffoldSnackBar(context, 'Task Deleted');
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text('Task Deleted'),
              //   duration: Duration(milliseconds: 500),
              // ));
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
              onTap: () => function ?? _onSelected(data[i]['id']),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    IconData(data[i]['icon'], fontFamily: 'MaterialIcons'),
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
          );
        },
        separatorBuilder: (ctx, i) => Container(
              padding: EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              )),
            ),
        itemCount: data.length);
  }
}
