import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskapp/dialogs.dart';
import 'package:taskapp/localnotification.dart';
import 'package:taskapp/main.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:taskapp/nav.dart';
import 'package:taskapp/signup.dart';

class Edittask extends StatefulWidget {
  Edittask(
      {super.key,
      required this.date,
      required this.title,
      required this.description,
      required this.id});
  String title;
  String description;
  String date;
  String id;
  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
  late DateTime _dateTime = DateTime.now();

  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _selecteddateTime = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _selecteddateTime.text = widget.date;
        _title.text = widget.title;
        _description.text = widget.description;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    mq = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Container(
          height: mq.height,
          width: mq.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff1d1e26),
              Color(0xff252041),
            ]),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 28,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Update Task',
                    style: TextStyle(
                      fontSize: 33,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // Title for the task
                  lable('Task Title'),

                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 55,
                    width: mq.width,
                    decoration: BoxDecoration(
                      color: const Color(0xff2a2e3d),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: _title,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Task Title",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  lable('Description'),
                  const SizedBox(
                    height: 12,
                  ),

                  //  Input field for Description
                  Container(
                    height: 150,
                    width: mq.width,
                    decoration: BoxDecoration(
                      color: const Color(0xff2a2e3d),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: _description,
                      maxLines: null,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //  lable for due date

                  lable('Due Date'),
                  const SizedBox(
                    height: 12,
                  ),

                  //  Date Time picker

                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    controller: _selecteddateTime,
                    dateMask: 'd MMM, yyyy',
                    // initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(
                      Icons.event,
                      color: Colors.white,
                    ),
                    dateLabelText: 'Date',
                    style: TextStyle(color: Colors.white),
                    timeLabelText: "Hour",
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }

                      return true;
                    },
                    onChanged: (val) {
                      setState(() {
                        _selecteddateTime.text = val;
                      });
                    },
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  // Add task button
                  InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                          Dialogs.showProgressIndicator(context);
                        try{
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(myUserId)
                            .collection('Tasks')
                            .doc(widget.id)
                            .update(
                          {
                            "title": _title.text,
                            "description": _description.text,
                            "date": _selecteddateTime.text
                          },
                        ).then((value) {
                            fetchTasksAndScheduleNotifications();
                            setState(() {
                              _title.text = "";
                              _description.text = "";
                              // _selecteddateTime.text = "";
                            });
                          });
                           Dialogs.showSnackbar(context, 'Task added Sucessfully');
                            Navigator.push(context, MaterialPageRoute(builder: (builder) => Nav()));
                        } catch (e) {
                          print("error =>$e");
                           Dialogs.showSnackbar(context,'Something went wrong');
                        }
                      }
                    },
                    child: Container(
                        height: 55,
                        width: mq.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff8a32f1), Color(0xffad32f9)]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Update Task',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    ));
  }

final NotificationService notificationService = NotificationService();
  void fetchTasksAndScheduleNotifications() async {
    // final tasks = await FirebaseFirestore.instance.collection('Task').get();
    // print(tasks);
    // for (var task in tasks.docs) {
    DateTime deadline = DateTime.parse(_selecteddateTime.text);
    //   print(deadline);
    DateTime notificationTime = deadline.subtract(Duration(minutes: 10));
    //   print(notificationTime);
    // Schedule the notification
    try {
      Random _random = Random();
      notificationService.scheduleNotification(
        _random.nextInt(2),
        'Task Reminder',
        'Your task "${_title.text}" is due soon!',
        notificationTime,
      );
    } catch (e) {
      print("error=> $e");
    }
  }

}

Widget lable(String lable) {
  return Text(
    lable,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16.5,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
  );
}
