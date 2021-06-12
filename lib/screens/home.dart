import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../screens/add_screen.dart';
import '../providers/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isUpdate = false;
  int _selectedIndex = 0;
  _onSelected(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('le ${Provider.of<DatabaseHelper>(context).tasks.length}');

    final providr = Provider.of<DatabaseHelper>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => AddScreen(),
              ),
            );
          }),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/download.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 30),
                          child: IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () =>
                                  _scaffoldKey.currentState.openDrawer(),
                              color: Colors.white,
                              iconSize: 30),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Your\nThings',
                            style: TextStyle(color: Colors.white, fontSize: 35),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 22, bottom: 20),
                              child: Text(
                                DateFormat('MMM d, yyyy')
                                    .format(DateTime.now()),
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 110),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FutureBuilder(
                                  future: providr.getCategoryCount(
                                      catName: "Personal"),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                                Text('Personal',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FutureBuilder(
                                  future: providr.getCategoryCount(
                                      catName: 'Bussinees'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data.toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      );
                                    }
                                    return Container();
                                  },
                                ),
                                Text('Bussiness',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, bottom: 20),
                              child: Row(
                                children: [
                                  FutureBuilder(
                                      future:
                                          Provider.of<DatabaseHelper>(context)
                                              .getCompletePrecntage(),
                                      builder: (ctx, snapshot) {
                                        if (snapshot.hasData) {
                                          return CircularPercentIndicator(
                                            radius: 25,
                                            lineWidth: 3,
                                            percent: snapshot.data,
                                            backgroundColor: Colors.grey,
                                            progressColor: Colors.cyan,
                                            animation: true,
                                          );
                                        }
                                        return Container();
                                      }),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  FutureBuilder(
                                      future:
                                          Provider.of<DatabaseHelper>(context)
                                              .getCompletePrecntage(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Text(
                                            '${((snapshot.data) * 100).toInt()}% done',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          );
                                        }
                                        return Container();
                                      }),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.60,
            child: ListView.separated(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
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
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                ),
                onDismissed: (dirction) {
                  providr.deleteTask(providr.tasks[i]['id']);
                },
                direction: DismissDirection.startToEnd,
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
                  onTap: () {
                    Provider.of<DatabaseHelper>(context, listen: false)
                        .updateDatabase(providr.tasks[i]['id']);
                    _onSelected(i);
                    print('ink tapped');
                  },
                  child: ListTile(
                    // tileColor: _selectedIndex != null && _selectedIndex == i
                    //     ? Colors.yellowAccent
                    //     : Colors.white,
                    // key: providr.tasks[i]['id'],
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconData(providr.tasks[i]['icon'],
                            fontFamily: 'MaterialIcons'),
                      ),
                    ),
                    title: Text(providr.tasks[i]['title']),
                    subtitle: Text(providr.tasks[i]['place']),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(providr.tasks[i]['time']),
                          SizedBox(
                            height: 5,
                          ),
                          Text(providr.tasks[i]['date']),
                        ],
                      ),
                    ),
                  ),

                  // (_selectedIndex == i)
                  //     ? Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Divider(
                  //           color: Colors.grey,
                  //           thickness: 1,
                  //         ),
                  //       )
                  //     : Container()
                ),
              ),
              separatorBuilder: (ctx, i) => Divider(thickness: 1),
              itemCount: providr.tasks.length,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  'COMPLETED  ',
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: FutureBuilder(
                      future: Provider.of<DatabaseHelper>(context)
                          .getCompleteCount(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '${((snapshot.data)).toInt()}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        }
                        return Container();
                      }),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

// Dismissible(
                    
                    
//                     onDismissed: (dirction) {
//                       providr.deleteTask(providr.tasks[i]['id']);
//                     },
//                     direction: DismissDirection.startToEnd,
//                     confirmDismiss: (direction) {
//                       return showDialog(
//                         context: context,
//                         builder: (ctx) => AlertDialog(
//                           title: Text('Are you sure'),
//                           content: Text('Do you want to remove this task?'),
//                           actions: [
//                             TextButton(
//                               child: Text('No'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                             TextButton(
//                               child: Text('Yes'),
//                               onPressed: () {
//                                 Navigator.of(context).pop(true);
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
                    
