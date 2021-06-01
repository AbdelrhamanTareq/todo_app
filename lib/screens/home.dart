import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
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
                                DateFormat('d MMM yyyy').format(DateTime.now()),
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
                                Text('24',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
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
                                Text('15',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25)),
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
                                  CircularPercentIndicator(
                                    radius: 25,
                                    lineWidth: 3,
                                    percent: 0.65,
                                    backgroundColor: Colors.grey,
                                    progressColor: Colors.cyan,
                                    animation: true,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '65% done',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
            height: MediaQuery.of(context).size.height * 0.55,
            child: ListView.separated(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, i) => ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.sports),
                ),
                title: Text('Boglioli suit fitting'),
                subtitle: Text('linnegatan 2, Gothnburg'),
                trailing: Text('9am'),
              ),
              separatorBuilder: (ctx, i) => Divider(),
              itemCount: 10,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: double.infinity,
            child: Text(
              'Completed 5',
              textAlign: TextAlign.left,
            ),
          ),
        ],
      )),
    );
  }
}
