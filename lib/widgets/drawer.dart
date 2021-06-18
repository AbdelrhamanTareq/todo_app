import 'package:flutter/material.dart';
import '../screens/setting_screen.dart';
import '../screens/done_screen.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 120, horizontal: 10),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                // to close Drawer when back to home Screen
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => DoneScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.done_rounded,
                      size: 35,
                      color: Colors.cyan,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Done',
                      style: TextStyle(fontSize: 25, color: Colors.cyan),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                // to close Drawer when back to home Screen
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => SettingScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 35,
                      color: Colors.cyan,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 25, color: Colors.cyan),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
