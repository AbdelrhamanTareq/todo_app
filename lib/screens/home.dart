import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../widgets/drawer.dart';
import '../widgets/list_view.dart';
import '../screens/add_screen.dart';
import '../providers/database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final providr = Provider.of<DatabaseHelper>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
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
            child: ListViewWidget(
              data: Provider.of<DatabaseHelper>(context).tasks,
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
