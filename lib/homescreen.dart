import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskapp/addtask.dart';
import 'package:taskapp/dialogs.dart';
import 'package:taskapp/localnotification.dart';
import 'package:taskapp/login.dart';
import 'package:taskapp/main.dart';
import 'package:taskapp/modal/taskmodal.dart';
import 'package:taskapp/signup.dart';
import 'package:taskapp/taskcard.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Dialogs.showSnackbar(context, ' Logout Sucessfully');
    } catch (e) {
      print("error =>$e");
      Dialogs.showSnackbar(context, 'Something went wrong');
    }
  }

  getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myUserId = prefs.getString('userID')!;
    });
  }

// AuthClass authClass = AuthClass[];
  // final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(myUserId)
  //     .collection('Tasks')
  //     .snapshots();

  List<Taskmodal> list = [];
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserID();
    notificationService.initializeNotifications();
    // fetchTasksAndScheduleNotifications();
  }

  @override
  Widget build(BuildContext context) {
    print("myuserId");
    return Scaffold(
      backgroundColor: Color(0xff252041),
      appBar: AppBar(
        leading: Icon(CupertinoIcons.home),
        title: Text('TaskApp'),
        actions: [
          // Signout button
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.remove('userID');
                myUserId = "";
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (builder) => Login()));
                await FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),

      // Task Card
      body: myUserId == ""
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(myUserId)
                  .collection('Tasks')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text(
                    "No Data Available",
                    style: TextStyle(color: Colors.white),
                  ));
                }
                print(snapshot.data!.docs.first.id);
                //
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    list = data
                            ?.map((e) => Taskmodal.fromJson(
                                e.data() as Map<String, dynamic>))
                            .toList() ??
                        [];

                    if (list.isNotEmpty) {
                      return ListView.builder(
                          itemCount: list.length,
                          padding: EdgeInsets.only(top: mq.height * .02),
                          itemBuilder: (context, index) {
                            return TaskCard(
                              status: list[index].status,
                              name: list[index].title,
                              date: list[index].date,
                              description: list[index].description,
                              id: data![index].id,
                            );
                          });
                    } else {
                      return const Center(
                          child: Text(
                        'No Connections Found!',
                        style: TextStyle(fontSize: 20),
                      ));
                    }
                }
              },
            ),
    );
  }
}

// floatingActionButton: FloatingActionButton(
//   onPressed:(() => signout()),
//   child: Icon(Icons.login_rounded),
//   ),
