import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/setting_screen.dart';
import '../providers/database.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _timeController = TextEditingController();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _placeController = TextEditingController();

  Future<void> _submit(
    String cat,
    String title,
    String place,
    String time,
    String date,
  ) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await Provider.of<DatabaseHelper>(context, listen: false)
          .insertToDatabase(
        cat: cat,
        title: title,
        place: place,
        time: time,
        date: date,
        icon: shownIcon.codePoint,
      );
      Navigator.of(context).pop();
    }
  }

  TextFormField textField({
    @required String title,
    @required Function validate,
    @required TextEditingController controller,
    Function onTap,
  }) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white),
      ),
      validator: validate,
    );
  }

  List<IconData> icons = [
    Icons.sports_soccer_rounded,
    Icons.music_note,
    Icons.design_services_sharp,
    Icons.timeline
  ];

  IconData shownIcon = Icons.sports_soccer_rounded;

  String category = 'Personal';

  List<String> categories = [
    "Personal",
    "Bussinees",
    "Other",
  ];
  String dropdownValue = "Personal";

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseHelper>(
      builder: (ctx, data, _) => Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: Text('Add new things'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  icon: Icon(Icons.dashboard_customize),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingScreen()),
                    );
                  }),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      color: Colors.deepPurple),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: shownIcon,
                        style: TextStyle(color: Colors.white),
                        iconSize: 0.0,
                        dropdownColor: Colors.black87,
                        elevation: 16,
                        onChanged: (newValue) {
                          setState(() {
                            shownIcon = newValue;

                            print(newValue);
                          });
                        },
                        items: icons.map((value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Icon(
                              value,
                              color: Colors.cyan,
                              size: 35,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  //  Icon(Icons.inbox_sharp, color: Colors.cyan),
                ),
              ),
              SizedBox(height: 50),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 15),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.black87,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          value: dropdownValue,
                          hint: Text(
                            "Category",
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                              category = newValue;
                            });
                          },
                          validator: (String value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter a valid type of business';
                            }
                            return null;
                          },
                          items: categories
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                        ),
                        textField(
                            controller: _titleController,
                            title: 'Title',
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            }),
                        textField(
                            controller: _placeController,
                            title: 'Place',
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'Please enter a place';
                              }
                              return null;
                            }),
                        textField(
                          controller: _timeController,
                          title: 'Time',
                          validate: (String val) {
                            if (val.isEmpty) {
                              return 'Please enter the time';
                            }
                            return null;
                          },
                          onTap: () async {
                            TimeOfDay time = TimeOfDay.now();
                            FocusScope.of(context).requestFocus(FocusNode());

                            TimeOfDay picked = await showTimePicker(
                                context: context, initialTime: time);
                            if (picked != null) {
                              _timeController.text =
                                  picked.format(context); // add this line.

                              setState(() {
                                time = picked;
                              });
                            }
                          },
                        ),
                        textField(
                            controller: _dateController,
                            title: 'Date',
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'Please enter a date';
                              }
                              return null;
                            },
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime date = DateTime(1900);
                              date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100),
                              );
                              _dateController.text =
                                  DateFormat('d/MM/yyyy').format(date);
                            }),
                        SizedBox(height: 25),
                        Container(
                          color: Colors.cyan,
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () => _submit(
                              category,
                              _titleController.text,
                              _placeController.text,
                              _timeController.text,
                              _dateController.text,
                            ),
                            child: Text(
                              'ADD YOUR THINGS',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
